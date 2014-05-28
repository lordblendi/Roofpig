#= require three.min
#= require roofpig/Pieces3D

mock_scene    = { add: -> }

mock_config = {
  hover: 1.0,
  colors: {
    to_draw: -> { hovers: true, color: 'red'}
    of: -> 'black'
  }
}
describe "Pieces3D", ->
  it ".make_stickers() creates Pieces3D.UBL, Pieces3D.UL, Pieces3D.F etc", ->
    pieces = new Pieces3D(mock_scene, mock_config)

    for piece in [pieces.UBL, pieces.UL, pieces.U]
      expect(piece).to.be.defined

    for piece in [pieces.BLU, pieces.WTF, pieces.LU]
      expect(piece).to.be.undefined

  it "keeps track of pieces and stickers", ->
    pieces = new Pieces3D(mock_scene, mock_config)

    expect(pieces.at.UFR.name).to.equal('UFR')
    expect(pieces.at.DR.name).to.equal('DR')
    expect(pieces.UFR.sticker_locations).to.deep.equal(['U', 'F', 'R'])
    expect(pieces.DR.sticker_locations).to.deep.equal(['D', 'R'])

    pieces.move(Side.R, 1)

    expect(pieces.at.UFR.name).to.equal('DFR')
    expect(pieces.at.DR.name).to.equal('BR')
    expect(pieces.DFR.sticker_locations).to.deep.equal(['F', 'U', 'R'])
    expect(pieces.BR.sticker_locations).to.deep.equal(['D', 'R'])

    pieces.move(Side.U, 2)

    expect(pieces.at.UFR.name).to.equal('UBL')
    expect(pieces.at.DR.name).to.equal('BR')

    expect(pieces.UBL.sticker_locations).to.deep.equal(['U', 'F', 'R'])

  it "#solved", ->
    solved = 'B BL BR D DB DBL DBR DF DFL DFR DL DR F FL FR L R U UB UBL UBR UF UFL UFR UL UR '

    pieces = new Pieces3D(mock_scene, mock_config)
    expect(pieces.state()).to.equal(solved)

    pieces.move(Side.R, 2)
    pieces.move(Side.R, -2)
    expect(pieces.state()).to.equal(solved)

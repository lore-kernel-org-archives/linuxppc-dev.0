Date: Thu, 14 Oct 1999 09:40:24 -0700
From: Matt Porter <mporter@eng.mcd.mot.com>
To: Simone Piccardi <Simone.Piccardi@fi.infn.it>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: BUGboot 0.2 - Boot Linux from flash on Moto boards
Message-ID: <19991014094024.A568@fwrsl-11.phx.mcd.mot.com>
References: <19990930134513.C25664@fwrsl-11.phx.mcd.mot.com> <3802668E.C5A6BAC6@fi.infn.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3802668E.C5A6BAC6@fi.infn.it>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Oct 12, 1999 at 12:37:03AM +0200, Simone Piccardi wrote:
> Hi Matt,
> 
> I'm trying your bugboot but I have some problem. I went through your
> readme, and these are the steps that I did.
> 
<snip>

Since I posted 0.2 I've been able to produce this problem with certain
board/zImage combinations.  This fell down my list of priorities a little
bit for the short term, but I will fix the problems and make a working
0.3 version available ASAP.

> I looked at what i have in memory:
> 
> PPC4-Bug>md ff000000:100
> FF000000  424F4F54 00000014 0009E95A 4C494E55  BOOT.......ZLINU
> FF000010  58524F4D 3D20FF00 61290100 3D600009  XROM= ..a)..=`..
> FF000020  616B7E4C 3D800000 618C5000 7D6903A6  ak~L=...a.P.}i..
> FF000030  39A00000 85690004 956C0004 7DAD5A78  9....i...l..}.Zx
> FF000040  4200FFF4 3D20FF09 61297F4C 3D600000  B...= ..a).L=`..
> FF000050  616B0000 3D800000 618C0000 7D6903A6 
> ak..=...a...}i..               
> FF000060  39A00000 85690004 956C0004 7DAD5A78  9....i...l..}.Zx
> FF000070  4200FFF4 3C600000 60630000 3DC00000  B...<`..`c..=...
> FF000080  61CE5400 7DC803A6 4E800020 00000000  a.T.}...N.. ....
> FF000090  00000000 00000000 00000000 00000000  ................
> and then all zero for 0x400 bytes excepted:
> FF0002C0  02004101 124F0000 0000C004 00000000 
> ..A..O..........                 
> FF0002D0  00000000 00000000 00000000 00000000 
> ................                 
> FF0002E0  00000000 00000000 00000000 00000000 
> ................                 
> FF0002F0  00000000 00000000 00000000 000055AA 
> ..............U.                 
> FF000300  00040000 4C7E0900 00004C69 6E757800 
> ....L~....Linux.                 

You've followed the steps correctly according to this memory dump.
I have definitely have some build problems in 0.2.

-- 
Matt Porter                                   Motorola Computer Group
mporter@mcg.mot.com                           CIBU Linux Support

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

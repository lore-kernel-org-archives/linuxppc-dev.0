From: deepesh@india.tejasnetworks.com
Date: Tue, 22 Jul 2003 21:22:03 +0530 (IST)
To: Steven Blakeslee <BlakesleeS@embeddedplanet.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: RE: EP8260 
In-Reply-To: <D73A25AA6E54D511AD74009027B1110F3C0957@ORION>
Message-ID: <Pine.LNX.4.21.0307222121140.3445-100000@deepesh.india.tejasnetworks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

  I checked the first sector, and I see the Hard Reset Configuration
Word. I think there is some other problem.

Deepesh

On Tue, 22 Jul 2003, Steven Blakeslee wrote:

> Was one of the sectors you erased the first sector? If so that is your
> problem, the hard reset word is located in the beginning of the first
> sector. To fix this you need to do the following.
>
> 1. There is a resistor that is removed from the board at location RO2.
> This resistor sets the default hard reset word. You have to put a 0ohm
> resistor at this location, a solder glob will also work.
> 2. Download the Planet Core FLASH burner and execute it. Give the
> command hrw to reburn the hard reset word. If the processor is 233MHz
> or higher give the command hrw h.
> 3. Remove the 0ohm resistor(or solder glob) at RO2.
>
> -----Original Message-----
> From: deepesh@india.tejasnetworks.com
> Sent: Tuesday, July 22, 2003 3:33 AM
> Subject: EP8260
>
>   I loaded my EP8260 board with UBOOT. This was working fine. Then I
> loaded a binary into RAM using tftp. Then tried copying the stuff to
> flash. When I could not copy things into flash directly, I erased a
> few sectors randomly and then copied the binary to flash. Then when I
> reset the board, it did not come up.
>
> I put back the u-boot into the flash using BDI2000. But now I am
> getting weird characters on the screen. I have looked at the minicom
> settings-- It is 115200 and 8N1. These were the settings with which
> I was working before also. What I am not able to understand is the
> reason for the weird characters.
>
> I am attaching the weird character file. The last line seems to be the
> U-BOOT prompt. I tried changing the TERMINAL SETTINGS to ANSI from
> VT100, but it did not help.
> ------------------------------------------------------------------------
> ?וךבף`*m,ןןפ`0nsnp`hSץל rr`r0ps`m@qrzs2zrvi
>
> ??fxrv0`?וףופ`?פבפץףz@?רפועמבל`?ןזפl ?רפועמבל`Èבעה
>
> ??fxrvp fלןדכ`fןמזיחץעבפיןמ
> `m`,ץףmפןmfןעו`?ץלפ`snuרl`-f?`?יצ rl`v0ר`,ץף`?עוס``sp-xu`l fןעו ?עוס qppm3pp
> `m`הזגעח`q,`דןעודמז`0רqוl`גץףהז`rl`דנםהז`ql`נללהז`ql`נללםז`r
> `m`צדןYןץפ``qyxppp0ppl`ףדדYדלכ```tyupppppl`געחYדלכ```1rswup0p
> `m`דנץYדלכ` rsqpppppp,`דנםYדלכ`@`yyp0ppppL`גץףYדלכ```vvp0pppp
>
> f?*z`` ??fxrvp`h?וצ`q4l`?בףכ`?n0h?i`r<ru?)`בפ`2sq`?Èת
> ,ןבעהz ?םגוההוה`?לבמופ`??x2vpl`?וציףיןמ`p.p
> ?2fz`` עובהש
> ????z `vt`?,
> ????^:`qv ?,
> jjj`-בעמימח`m`גבה`f?fl`ץףימח`הוזבץלפ`ומציעןמםומפ
>
> ?מz` ``ףועיבל
> ?ץפz ``ףועיבל
> ?עעz ``ףועיבל
> ?Åפz```?ffs`??^?????
> ,??,*?zעוÁהש
> }~`
> --------------------------------------------------------------------------

--

D.Deepesh
R&D Engineer,
Tejas Networks

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

From: "Chuck Meade" <chuckmeade@mindspring.com>
To: "L. Puneeth Rao" <puneeth_l@roc.co.in>,
	<linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Peculiar problem(s) on MBX board
Date: Sun, 23 Nov 2003 23:42:36 -0500
Message-ID: <IIEEICKJLNEPBBDJICNGIEFEEDAA.chuckmeade@mindspring.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <5.2.0.9.0.20031124101121.027949a0@172.16.15.10>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Try running dos2unix on your s-record file.  The char 0xd
is a <CR>.

Chuck Meade

> -----Original Message-----
> From: owner-linuxppc-embedded@lists.linuxppc.org
> [mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of L.
> Puneeth Rao
> Sent: Sunday, November 23, 2003 11:42 PM
> To: linuxppc-embedded@lists.linuxppc.org
> Subject: Peculiar problem(s) on MBX board
>
>
>
> Greetings All,
>          I have a MBX evaluation board with a MPC860T processor. I have
> used 2.4.18 kernel sources,  ppc-patch-2.4.18, cross compiler
> gcc-core-3.3.1 and binutils-2.11.90.0.8. to obtain a zImage on a x86 host
> machine. To download this image to the board i have used TFTP server-client
> technique. But the TFTP client on the board reported a "Transmission
> carrier sense lost error" ( eppcbug error-14). In fact i am unable to ping
> to any machine in my network from the eppcbug prompt.
>          Therefore I obtained image.srec (using powerpc-linux-objcopy) and
> tried to transfer the image through serial port (using lo command at the
> eppcbug prompt and minicom) but eppcbug is reporting a "S-record character
> error" with error char = $0D and the malicious s-record is
> S1F0002015554466723232F. And there is no such record in the image.srec file
>          Here is a snapshot of image.srec
>                  S00F0000707063626F6F742E737265631E
>                  S315FE00000027051956505043426F6F7420312E322EFB
>                  ........
> Upon taking a closer look at the 2nd s-record in the image.srec we can see
> that the malicious s-record reported by eppcbug can be obtained by
> extracting all the alternative characters and clubbing them together.
>          Kindly suggest a way out. TIA
> With regards,
> Puneeth
>
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Subject: RE: DMA support for MPC5xxx? 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Thu, 3 Jun 2004 12:50:56 +0200
Message-ID: <42A622EB18325843894BB8E1040E3DF5022734@sinaexchf>
From: =?iso-8859-1?Q?I=F1igo_Lopez_Barranco?= <ilopez@albatros-sl.es>
To: "Wolfgang Denk" <wd@denx.de>
Cc: <linuxppc-dev@lists.linuxppc.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Thanks for your answer. Is there any place to follow the evolution of this problem, kind of bestcomm project web page or mail list, or is this list where motorola people uses to announce new bestcomm releases?
Thanks

Iñigo


-----Mensaje original-----
De: Wolfgang Denk [mailto:wd@denx.de]
Enviado el: mié 02/06/2004 17:08
Para: Iñigo Lopez Barranco
CC: linuxppc-dev@lists.linuxppc.org
Asunto: Re: DMA support for MPC5xxx?

In message <42A622EB18325843894BB8E1040E3DF5022732@sinaexchf> you wrote:
>
> Are MPC5200's IDE UDMA and MDMA have support with the latests changes in bestcomm?

Yes, partially :-(

> As I've read in the list, IDE and DMA were not supported due to bestcomm microcode (http://lists.linuxppc.org/linuxppc-embedded/200403/msg00214.html). Then, there is an announcement about a new API released on april 2004, included in linuxppc_2_4_devel
> cvs module. Does this solve the IDE DMA problem? I'm trying to use it on linuxppc_2_4_devel but doesn't work and I don't know if it's broken or I'm doing something wrong.
> BTW, the target is a Lite5200 board.

IDE DMA works if used alone, but it still causes conflicts  when  the
FEC ethernet driver is enabled, too. Motorola is investigating.


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"It takes all sorts of in & out-door schooling to get adapted  to  my
kind of fooling"                                           - R. Frost


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

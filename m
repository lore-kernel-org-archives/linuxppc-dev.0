Date: 29 Sep 2003 15:49:57 -0000
Message-ID: <20030929154957.29503.qmail@webmail27.rediffmail.com>
MIME-Version: 1.0
From: "somshekar chandrashekar kadam" <som_kadam1@rediffmail.com>
Reply-To: "somshekar chandrashekar kadam" <som_kadam1@rediffmail.com>
To: "Graf Alex" <alex.graf@siemens.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: AW: compact flash
Content-type: text/plain;
	format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Alex,

  Thanks A lot , u cleared my so many doubts ,

i Have configured kernel and first I am trying to detect my CF on
Linux kernel,

do i need to first detect it on my PPCBOOT , or can I make it
DETECT directly from LINUX

Thanks Once again
Regards
SOmshekar
On Mon, 29 Sep 2003 Graf Alex wrote :
>which compact flash card can i use with maximum memory ,
> >> u can use any CF (compact flash) card. The thing is, how you
>address the
>card. PCMCIA or CF. With PCMCIA u can address up to 64 MB. With
>IDE much
>more as any CF card memory has :-)
>
>apart from kernel support for hot pluggable , IDE support and
>flash file system support , what are things i need to get
>compact
>flash working , I am confused here
> >> best is to start work with ELDK from denx.de. There is the
>PCMCIA and IDE
>support solved.
>
>MPC860 provide interface for PCMCIA, which can be interfaced to
>COMPACT FLASH also if i am not wrong ?
> >> No, u are rigth.
>
>cheers
>
>Alex Graf


On Mon, 29 Sep 2003 Graf Alex wrote :
>which compact flash card can i use with maximum memory ,
> >> u can use any CF (compact flash) card. The thing is, how you
>address the
>card. PCMCIA or CF. With PCMCIA u can address up to 64 MB. With
>IDE much
>more as any CF card memory has :-)
>
>apart from kernel support for hot pluggable , IDE support and
>flash file system support , what are things i need to get
>compact
>flash working , I am confused here
> >> best is to start work with ELDK from denx.de. There is the
>PCMCIA and IDE
>support solved.
>
>MPC860 provide interface for PCMCIA, which can be interfaced to
>COMPACT FLASH also if i am not wrong ?
> >> No, u are rigth.
>
>cheers
>
>Alex Graf


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

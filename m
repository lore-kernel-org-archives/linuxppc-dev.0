Content-Type: text/plain;
  charset="iso-8859-1"
From: Mark Chambers <markc@mail.com>
Reply-To: markc@mail.com
To: "Kerl, John" <John.Kerl@Avnet.com>, der.herr@mail.hofr.at
Subject: Re: Control-C in bash ???
Date: Mon, 13 Jan 2003 14:39:48 -0500
Cc: linuxppc-embedded@lists.linuxppc.org
References: <C08678384BE7D311B4D70004ACA3710511194632@amer22.avnet.com>
In-Reply-To: <C08678384BE7D311B4D70004ACA3710511194632@amer22.avnet.com>
MIME-Version: 1.0
Message-Id: <200301131439.48082.markc@mail.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thanks for your suggestions, that perhaps the terminal emulator was eating the
Ctl^C.  I scope'd the cable and it appears that the Ctl^C IS in fact getting
transmitted.

Mark C.

> One little gotcha that I ran into was that control-C was being
> grabbed by the terminal emulator on my PC.  You might try
>

Original question:  Why is Ctl^C not breaking out of programs?

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

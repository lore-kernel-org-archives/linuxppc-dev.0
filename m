Message-ID: <402B4A75.8080005@imc-berlin.de>
Date: Thu, 12 Feb 2004 10:42:13 +0100
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: DavidHo@nanometrics.ca
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: EXT_DIRECT IDE Mode
References: <OF84D144C1.127F1138-ON85256E37.0066D679-85256E37.0067E43D@nanometrics.ca>
In-Reply-To: <OF84D144C1.127F1138-ON85256E37.0066D679-85256E37.0067E43D@nanometrics.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


DavidHo,

> I'm using a variant of the 2.4.18 kernel from timesys.
>
> The kernel is compiled with those settings.  (in your email)
>
> I had to add a call to m8xx_ide_init in m8xx-setup.c at the end of
> platform_init.
>
> I can only find these defines in ide-m8xx.c.  I am thinking there must be
> more to it than the one file.

Hmm. 2.4.18 is pretty old. I don't know if there's support for MPC8xx IDE!

CONFIG_IDE_EXT_DIRECT was introduced long (!) after
CONFIG_IDE_8xx_PCCARD and CONFIG_IDE_8xx_DIRECT.

Did you add the code for IDE_EXT_DIRECT yourself?

Steven


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

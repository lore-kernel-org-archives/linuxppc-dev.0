From: DavidHo@nanometrics.ca
In-Reply-To: <402B4A75.8080005@imc-berlin.de>
Subject: Re: EXT_DIRECT IDE Mode
To: linuxppc-embedded@lists.linuxppc.org
Message-ID: <OF02AD3731.48F9A02B-ON85256E38.0050E0C6-85256E38.0062E6C8@nanometrics.ca>
Date: Thu, 12 Feb 2004 13:00:16 -0500
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


The EXT_DIRECT item is already there in the configuration menu.  I thought
it has been fully implemented in that version, until I saw the functions
are not being called in platform_init.

Base on your knowledge, which kernel version has this mode (MPC8xx IDE)
fully working?

And do you know the work involved in porting the support to 2.4.18?  I am
gauging which is the easier route moving all the changes I have already
made to 2.4.2x or porting the changes to 2.4.18.

David




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

Subject: Re: EXT_DIRECT IDE Mode
From: Jaap-Jan Boor <jjboor@aimsys.nl>
To: DavidHo@nanometrics.ca
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <OF02AD3731.48F9A02B-ON85256E38.0050E0C6-85256E38.0062E6C8@nanometrics.ca>
References: 
	 <OF02AD3731.48F9A02B-ON85256E38.0050E0C6-85256E38.0062E6C8@nanometrics.ca>
Content-Type: text/plain
Message-Id: <1076609818.6176.20.camel@linpc003.aimsys.nl>
Mime-Version: 1.0
Date: Thu, 12 Feb 2004 19:16:58 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


David,

Should there not be a call to the 8xx init function between
#ifdef CONFIG_IDE_EXT_DIRECT / #endif in
driver/ide/ide.c ?
There are a lot such init calls there

Jaap-Jan



On Thu, 2004-02-12 at 19:00, DavidHo@nanometrics.ca wrote:
> The EXT_DIRECT item is already there in the configuration menu.  I thought
> it has been fully implemented in that version, until I saw the functions
> are not being called in platform_init.
>
> Base on your knowledge, which kernel version has this mode (MPC8xx IDE)
> fully working?
>
> And do you know the work involved in porting the support to 2.4.18?  I am
> gauging which is the easier route moving all the changes I have already
> made to 2.4.2x or porting the changes to 2.4.18.
>
> David
>
>
>
>
> > I'm using a variant of the 2.4.18 kernel from timesys.
> >
> > The kernel is compiled with those settings.  (in your email)
> >
> > I had to add a call to m8xx_ide_init in m8xx-setup.c at the end of
> > platform_init.
> >
> > I can only find these defines in ide-m8xx.c.  I am thinking there must be
> > more to it than the one file.
>
> Hmm. 2.4.18 is pretty old. I don't know if there's support for MPC8xx IDE!
>
> CONFIG_IDE_EXT_DIRECT was introduced long (!) after
> CONFIG_IDE_8xx_PCCARD and CONFIG_IDE_8xx_DIRECT.
>
> Did you add the code for IDE_EXT_DIRECT yourself?
>
> Steven
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

From: "Chris Hallinan" <clh@net1plus.com>
To: "Eli Brin" <elib@rokonet.co.il>, <brian.auld@adic.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Problems installing DENX ELDK
Date: Sun, 26 Jan 2003 12:35:32 -0500
Message-ID: <NEBBKJPFOLJNBMFNKBIIAEGCDEAA.clh@net1plus.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <75DF04AC5ED4D511A9810090273CB4163A67B6@ROKONET-E>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I have occasionally encountered problems with the download itself.
I assumed it was my ISP or simply 'net congestion.  It seems that
ncftp is not great at informing the user of problems with the
download.  I have experienced several times where the 'get ...'
command does not in fact download every file, and it seems to remain
silent about some types of errors.  I have seen it terminate more
than once without reporting errors, although not every file was
downloaded.

What I have done in the past is to issue the command repeatedly
until all the files were downloaded.  In earlier versions (those
distributed with RedHat 7.x, you could see each file reported as
something like "File already downloaded, skipping..." but in the
ncftp version distributed w/ RH8.0, ncftp is silent about that, too.

I'm sure those more familiar with ncftp could suggest a better way!!
I haven't bothered, because the above works for me.

-Chris Hallinan
DS4.COM, Inc.



> -----Original Message-----
> From: owner-linuxppc-embedded@lists.linuxppc.org
> [mailto:owner-linuxppc-embedded@lists.linuxppc.org]On
> Behalf Of Eli Brin
> Sent: Sunday, January 26, 2003 8:31 AM
> To: 'brian.auld@adic.com'
> Cc: 'linuxppc-embedded@lists.linuxppc.org'
> Subject: RE: Problems installing DENX ELDK
>
>
>
> Hi Brian,
>
> We have installed the ELDK 2.0.2 (ppc_8xx) on Redhat
> Linux 8.0 without any
> problems.  I suggest to create and installation CD (ISO
> image), and begin
> the installation from there.
>
> Every thing is covered in the documentation.
>
> Best Regards,
> Eli Brin
>
>
>
> -----Original Message-----
> From: brian.auld@adic.com [mailto:brian.auld@adic.com]
> Sent: Friday, January 24, 2003 6:12 PM
> To: linuxppc-embedded@lists.linuxppc.org
> Subject: Problems installing DENX ELDK
>
>
>
> I am trying to setup my tool-chain for embedded PPC
> development. I am
> considering different approaches, one of them using DENX's ELDK.
>
> Regarding the DENX option, I'm not getting very far as
> after having run the
> "get -R eldk-ppc-linux-x86" command as per the
> installation instructions, I
> find that underlying files in the, for example, "tools"
> directory do not
> exist. I therefore cannot proceed with the installation.
>
> Have others had problems downloading and installing (vers
> 2.0.2) of this
> kit? I also found that the directory structure within
> 'eldk-linux-ppc-x86'
> directory is not consistent with what's in the document.
>
> Thanks
>
> -- Brian
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

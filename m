Subject: RE: Need clarity on compiler & emulator usage
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Mon, 1 Mar 2004 07:08:45 -0700
Message-ID: <8039970AF146314597457D3B51A68B388F36A5@cossmgmbx02.email.corp.tld>
From: "VanBaren, Gerald (AGRE)" <Gerald.VanBaren@smiths-aerospace.com>
To: <uclinux-dev@uclinux.org>, <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Also, vision* only runs under Microsoft OSes (currently).  BDI2000 supports the GNU gdb target server protocol over ethernet, so any OS that supports gdb will be supported by the BDI2000.  That is a LARGE list.

gvb


> -----Original Message-----
> From: owner-linuxppc-embedded@lists.linuxppc.org
> [mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of Wells,
> Charles
> Sent: Monday, March 01, 2004 9:02 AM
> To: 'Thamarai Selvan'; linuxppc-embedded@lists.linuxppc.org
> Cc: uclinux-dev@uclinux.org
> Subject: RE: Need clarity on compiler & emulator usage
>
>
>
> Thamarai Selvan wrote:
>
> >can we use vision ice emulators to download the image if not why?
>
> I realized I didn't answer this question in my last response.  The
> short answer is yes.  visionICE will download a Linux image just fine.
>
> I successfully ported Linux to our custom MPC850 hardware and I used
> visionICE/visionEVENT/visionCLICK to do it.  The problem arises when
> the startup code turns the MMU on.  At that point, the visionICE/
> visionCLICK combination becomes useless.  Further, there is no support
> for either kernel or user-land debugging once Linux is up and running.
>
> Note that our visionICE hardware and visionCLICK software is a couple
> of years old and WRS may have added some Linux support since
> that time.
>
> I'd still like to have a BDI2000.
>
> Regards,
> Charlie
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

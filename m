From: Eric Benard <ebenard@ifrance.com>
To: Paul Mackerras <paulus@linuxcare.com>
Subject: Re: 2.3.43 failed
Date: Mon, 14 Feb 2000 09:53:51 +0100
Content-Type: text/plain
References: <00021211003504.00821@linux.eric.fr> <00021318311301.12422@argo.linuxcare.com.au>
In-Reply-To: <00021318311301.12422@argo.linuxcare.com.au>
Cc: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Message-Id: <00021409555701.01375@linux.eric.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Le dim, 13 fév 2000, Paul Mackerras a écrit :
> On Sat, 12 Feb 2000, Eric Benard wrote:
>
> > it compiles fine on a B&W G3 but doesn't run : it stops after the "Booting..."
> > message.
>
> I just updated linuxcare.com.au::linux-pmac-devel to 2.3.44 final.  I
> fixed a couple of problems where it would hang during boot if you booted
> from OF (or with quik or yaboot) and it couldn't find the screen.  Try it
> now.  If it doesn't work, let me know (and tell me how you are booting it).
>
I just tried with the 2.3.45 from linux-pmac-devel and it makes exctlly the
same thing.
I'm using BootX 1.2b1 with MacOS 8.6 to boot.

My root partition is on an external SCSI HD connected to an Adaptec 2906 scsi
card.


Eric

______________________________________________________________________________
Si votre email etait sur iFrance vous pourriez ecouter ce message au tel !
http://www.ifrance.com : ne laissez plus vos emails loin de vous ...
gratuit sur iFrance :  emails (20 MO, POP, FAX), Agenda, Site perso

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Message-ID: <38770856.2F55A3E7@pop.agri.ch>
Date: Sat, 08 Jan 2000 10:50:14 +0100
From: Andreas Tobler <toa@pop.agri.ch>
Reply-To: toa@pop.agri.ch
MIME-Version: 1.0
To: Linux -Dev <linuxppc-dev@lists.linuxppc.org>
Subject: [Fwd: remote debugging?]
Content-Type: multipart/mixed;
 boundary="------------2145C10A9BE111C6B393270D"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------2145C10A9BE111C6B393270D
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit


This should have gone to the list too....
Andreas
--------------2145C10A9BE111C6B393270D
Content-Type: message/rfc822
Content-Disposition: inline

X-Mozilla-Status2: 00000000
Message-ID: <38751C3D.31D2DAC2@pop.agri.ch>
Date: Thu, 06 Jan 2000 23:50:47 +0100
From: Andreas Tobler <toa@pop.agri.ch>
Reply-To: toa@pop.agri.ch
Organization: zero
X-Mailer: Mozilla 4.61 (Macintosh; I; PPC)
X-Accept-Language: en
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>,
 	Charles Lepple <clepple@mitre.org>
Subject: Re: remote debugging?
References: <Pine.LNX.4.05.10001062118200.11905-100000@callisto.of.borg>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi all,

Geert got it!!

Geert Uytterhoeven wrote:
> 
> On Thu, 6 Jan 2000, Andreas Tobler wrote:
> > I try to remote debugging a kernel.
> > Configuration as follows:
> >
> > pm7200 Linux <------ serial cable------> PowerBook MacOS ZTerm
> >
> > the physical Link is ok, when cat'ing a file to /dev/ttyS1 I get it on
> > the ZTerm window.
> >
> > But when I boot with BootX I add the kernel args 'console=/dev/ttyS1' in
> > the corresponding field.
> >
> > The first stage text I see on the pm7200, afterwards Tux comes up and no
> > booting messages are seen either on the pm7200 (what I expect) nor on
> > the ZTerm window. (what I don't expect).
> 
> And you did enable CONFIG_SERIAL_CONSOLE?
> 
> I'm not 100% sure that it works on PowerMac (don't have one), but at least
> CONFIG_SERIAL_CONSOLE is in the macserial code.

my problem was not having activated the second point in 'General setup'
Mac serial support: CONFIG_SERIAL_CONSOLE: the console support!!

(while building the kernel)

Now I get the boot messages printed out to my serial connection. Yeah!

One point which I think is important, is, the kernel args is
'console=ttySX' where X is the connected serial line. Normally one or
two. (Modem/printer on a pm7200)
And NOT console=/dev/ttySX

maybe someone else can use this.....

Thanks,

Andreas

-- 
| Andreas Tobler				
| CH-8004 Zuerich 							
| E-Mail:   a.tobler@schweiz.ch
-----------------------------------------------

--------------2145C10A9BE111C6B393270D--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

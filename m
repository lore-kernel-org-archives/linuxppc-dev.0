From: Steve.Ferri@radisys.com
To: <acurtis@onz.com>
Cc: "Jean-Denis Boyer" <jdboyer@mediatrix.com>,
	linuxppc-embedded@lists.linuxppc.org,
	owner-linuxppc-embedded@lists.linuxppc.org
Subject: RE: Unhandled interrupt 0, disabled
MIME-Version: 1.0
Message-ID: <OFDC1ED295.5E02AFDD-ON85256BAE.005E00E8@radisys.com>
Date: Fri, 3 May 2002 13:22:43 -0400
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Allen,

We are using a PMC board that has the B.3 version of the 8260 along with
the
Tundra PowerSpan 420.  I haven't seen any CP hang problems
with regards the on board PCI controller.  The PowerSpan is connected to
the
8260's external interrupt line IRQ3.  We are using a custom PCI driver
for host to daughter card communication, where the 8260 card is acting as
a daughter card.

Now working with the MCC devices on the B.3 version of the 8260 is another
story...

Regards,
Steve

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Steve Ferri                         Radisys Corporation
Tel: 856 642-9229 x239  520 Fellowship Rd.
Fax: 856 642-0252            Suite C-304
www.radisys.com             Mt. Laurel, NJ 08054







"Allen Curtis" <acurtis@onz.com>
Sent by: owner-linuxppc-embedded@lists.linuxppc.org
05/03/02 11:31 AM
Please respond to acurtis


        To:     "Jean-Denis Boyer" <jdboyer@mediatrix.com>, <Steve.Ferri@radisys.com>
        cc:     <linuxppc-embedded@lists.linuxppc.org>
        Subject:        RE: Unhandled interrupt 0, disabled



> Just put the 'sync' in __sti().
> It seems to fix the problem on both 2.4.10 and 2.4.18,
> which are the versions I have tested.
>
> > I am using the B.3 version of the 8260

I know that this is unrelated but could you confirm whether B.3 and higher
fixes the CP hang problem when using an external PCI controller such as
the
PowerSpan.

Thanks


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Date: Wed, 2 May 2001 20:57:46 +0200
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: John Fremlin <chief@bandits.org>
Cc: "Grover, Andrew" <andrew.grover@intel.com>,
	"Acpi-PM (E-mail)" <linux-power@phobos.fachschaften.tu-muenchen.de>,
	sfr@canb.auug.org.au, linux-arm-kernel@lists.arm.linux.org.uk,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: pmevent patch and PM
Message-ID: <20010502205746.G11059@arthur.ubicom.tudelft.nl>
References: <4148FEAAD879D311AC5700A0C969E89006CDDD9D@orsmsx35.jf.intel.com> <m23danaayj.fsf@boreas.yi.org.>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <m23danaayj.fsf@boreas.yi.org.>; from chief@bandits.org on Wed, May 02, 2001 at 06:59:32PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, May 02, 2001 at 06:59:32PM +0100, John Fremlin wrote:
> Hi PM maintainers! ARM and PPC ppl, who is your PM maintainer?

We (= ARM people) have a couple of them, there is no real "PM
maintainer". We do clock switching (on SA11x0 and XScale), CPU core
voltage switching, and other things. Note that most ARM systems don't
have things like ACPI BIOSes that do funky things, everything is
controlled from the OS. Russell usually coordinates things.


Erik

--
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

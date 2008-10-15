Return-Path: <bgat@billgatliff.com>
Message-ID: <48F635A2.1090709@billgatliff.com>
Date: Wed, 15 Oct 2008 13:25:38 -0500
From: Bill Gatliff <bgat@billgatliff.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	ARM Linux Mailing List <linux-arm-kernel@lists.arm.linux.org.uk>,
	kernel@avr32linux.org
Subject: Proposal for a Generic PWM Device API posted on linux-embedded
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Greetings, all!


I just posted code to implement a Generic PWM Device API to linux-embedded.  If
you need them, archives of that mailing list are available at the following link
(and elsewhere):

http://www.mail-archive.com/linux-embedded@vger.kernel.org/

Previous versions of this code were posted on linux-arm-kernel, linuxppc-dev,
avr32linux.org and elsewhere.  It's an API that cuts across machine
architectures--- not unlike the GPIO API--- and I really appreciate the
constructive feedback I have received from all corners of the architecture globe.

Multiple reviewers suggested that the best place to review the final code is
linux-embedded, rather than cross-posting all over the place.  I encourage you
to submit your feedback there.

I would love to see this code included in the mainline kernel at some point in
the not-too-distant future.  It has proven very useful to me, I think it will be
useful for many others as well.


Kindest regards,


b.g.
-- 
Bill Gatliff
bgat@billgatliff.com

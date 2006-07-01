Return-Path: <wd@denx.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Video Card to Lite5200 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sat, 01 Jul 2006 09:16:07 +1000."
	<1151709367.27137.4.camel@localhost.localdomain>
Date: Sat, 01 Jul 2006 11:15:07 +0200
Sender: wd@denx.de
Message-Id: <20060701091507.EA1F4352681@atlas.denx.de>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	roger blofeld <blofeldus@yahoo.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In message <1151709367.27137.4.camel@localhost.localdomain> you wrote:
>
> > I don;t know - the patches were submitted to this list  a  long  time
> > ago; we added them to our repository without any additional problems;
> > see http://www.denx.de/cgi-bin/gitweb.cgi?p=linux-2.6-denx.git
> 
> Any reason why you keep that repository instead of submiting the patches
> for proper upstream inclusion or to linuxppc-dev at least ?

We submit patches every now and then, as time permits.  My  intention
is to keep the differences between our tree and kernel.org minimal.

But you know how this goes: just adding support for a new board means
sending patches to the linuxppc_dev, mtd, i2c, usb,  lm_sensors,  ...
mailing  lists. Then you have to wait some time, then you resend. and
you have to keep track of all these things.  And  the  board  support
will  not  work  before the last piece of the puzze has been accepted
and merged and pushed upstream. All this takes a lot  of  effort  and
even  more  calendar time. We need a way to provide a solution to our
customers fast - that's why we maintain our own development branch.

I'd be happy if you could recommend a better approach to handle this.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
The management question ... is not _whether_ to build a pilot  system
and  throw  it away. You _will_ do that. The only question is whether
to plan in advance to build a throwaway, or to promise to deliver the
throwaway to customers.       - Fred Brooks, "The Mythical Man Month"

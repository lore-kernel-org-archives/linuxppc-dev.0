Return-Path: <annamaya@yahoo.com>
Received: from web53806.mail.yahoo.com (web53806.mail.yahoo.com
	[206.190.36.201]) by ozlabs.org (Postfix) with SMTP id DBC8067A86
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 27 Jan 2005 06:15:34 +1100 (EST)
Message-ID: <20050126191532.13770.qmail@web53806.mail.yahoo.com>
Date: Wed, 26 Jan 2005 11:15:32 -0800 (PST)
From: annamaya <annamaya@yahoo.com>
To: Dan Malek <dan@embeddededge.com>
In-Reply-To: <BD936D78-6FCC-11D9-A0FB-003065F9B7DC@embeddededge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Is there a DER for the MPC82xx?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dan,

Thanks for the reply. I do not understand the standard
COP interface very well, and hence the confusion.

On the 8xx, I had to worry about the DER cause that
was exactly what was set in the config file early on.
For example, if I did not have the external interrupt
bit set, I could not see that an external reset signal
was being asserted. Instead, all I would see is a
machine check somewhere else in the code.

I guess I am fine on the 82xx then. Great!

--- Dan Malek <dan@embeddededge.com> wrote:

> 
> On Jan 26, 2005, at 10:53 AM, annamaya wrote:
> 
> > Can someone tell me if the BDI will be able to
> catch
> > all different kinds of exceptions/interrupts on
> the
> > MPC82xx without requiring any special register
> > programming? I am unable to find anything that
> that
> > resembles the DER register on the MPC8280.
> 
> The BDI2000 works very nicely on 82xx processors.
> The 82xx debug unit is the standard COP interface,
> completely different from the 8xx debug interface.
> Stop looking for a DER on the 82xx, plug in the
> BDI2000 and use it.  Make sure you understand all
> of the features of the BDI2000, as even on the 8xx
> you should not be worrying about the DER. Let the
> BDI2000 configure all of that accordingly based upon
> what you are asking it to do.
> 
> 
> 	-- Dan
> 
> 



		
__________________________________ 
Do you Yahoo!? 
Yahoo! Mail - now with 250MB free storage. Learn more.
http://info.mail.yahoo.com/mail_250

Return-Path: <annamaya@yahoo.com>
Received: from web53801.mail.yahoo.com (web53801.mail.yahoo.com
	[206.190.36.196]) by ozlabs.org (Postfix) with SMTP id ED6C267A90
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 27 Jan 2005 09:22:17 +1100 (EST)
Message-ID: <20050126222216.87121.qmail@web53801.mail.yahoo.com>
Date: Wed, 26 Jan 2005 14:22:16 -0800 (PST)
From: annamaya <annamaya@yahoo.com>
To: Dan Malek <dan@embeddededge.com>, Mark Chambers <markc@mail.com>
In-Reply-To: <ECCFD7F0-6FDF-11D9-A0FB-003065F9B7DC@embeddededge.com>
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

Dan and Mark,

Thanks for talking about this a little more and making
it a much clearer for me. I do have VECTOR CATCH
enabled. I am going to keep my fingers crossed. :-)


--- Dan Malek <dan@embeddededge.com> wrote:

> 
> On Jan 26, 2005, at 12:33 PM, Mark Chambers wrote:
> 
> > P.S. I've read the BDI manual - I don't see it. 
> My manual
> > says the BDI can only set one hardware breakpoint,
> and
> > stuff like VECTOR CATCH assumes valid memory.
> 
> The BDI2000 lets you set as many hardware
> breakpoints
> as the processor supports.  The VECTOR CATCH is
> equivalent
> to setting of the bits in the DER.  I don't know
> where you
> determined it requires valid memory, as it catches
> the vector
> before it starts to execute the instructions in the
> trap handler.
> I don't know the COP details, there may be versions
> that don't
> have sufficient hardware support, and in that case
> it would
> have to be implemented by stuffing breakpoints into
> all of
> the vector tables, but that is just speculation on
> my part and
> have never seen that done.  I've used VECTOR CATCH
> on
> 603 cores and had it trap properly before memory was
> initialized.
> Using VECTOR CATCH seems to have no effect on
> setting
> other breakpoints.
> 
> Yes, you can manually set bits in the DER and get a
> different
> control over the debugging environment, but you have
> to
> be conscious of what the BDI2000 is also trying to
> do with
> that and other debug registers, too :-)
> 
> 
> 	-- Dan
> 
> 



		
__________________________________ 
Do you Yahoo!? 
Yahoo! Mail - Easier than ever with enhanced search. Learn more.
http://info.mail.yahoo.com/mail_250

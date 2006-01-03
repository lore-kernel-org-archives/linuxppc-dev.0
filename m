Return-Path: <grant.likely@secretlab.ca>
Received: from outbound-mail-25.bluehost.com (outbound-mail-25.bluehost.com
	[70.103.189.20]) by ozlabs.org (Postfix) with SMTP id 2B1EB68990
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  3 Jan 2006 15:00:00 +1100 (EST)
Message-ID: <43B9F69B.6090407@secretlab.ca>
Date: Mon, 02 Jan 2006 20:59:23 -0700
From: Grant Likely <grant.likely@secretlab.ca>
MIME-Version: 1.0
To: Brett McNerney <mcnernbm@notes.udayton.edu>
References: <000101c61017$ec64d080$0202a8c0@lilmac>
In-Reply-To: <000101c61017$ec64d080$0202a8c0@lilmac>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Custom Driver
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Brett McNerney wrote:
> I am need to create a driver to interface to custom hardware on a ml403
> board.  I am first trying to just create a ipif register bank and access
> the registers from linux but am not having any luck of yet.  Has anyone
> successfully done this and if so explain how or supply a driver to do
> this and how to build it into the kernel?  I am new at this and am
> having great difficutly right now. 
> 
> Thanks for any help anyone can supply
Can you access your device from a debugger, or a no-os program (like a
bootloader)?  Did you call ioremap() to map the physical register
address into virtual memory?  Can you give more detail?

g.


-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
(403) 663-0761

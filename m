Return-Path: <nd@bplan-gmbh.de>
Date: Thu, 2 Nov 2006 17:27:02 +0100 (MET)
Message-ID: <454A1C37.5050208@bplan-gmbh.de>
From: Nicolas DET <nd@bplan-gmbh.de>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH/RFC] powerpc: Add MPC5200 Interrupt Controller support.
References: <454902F9.20206@bplan-gmbh.de>
	<1162419138.25682.453.camel@localhost.localdomain>
In-Reply-To: <1162419138.25682.453.camel@localhost.localdomain>
Content-Type: multipart/mixed; boundary="------------030204080309010709010900"
Cc: linuxppc-dev@ozlabs.org, Sylvain Munaut <tnt@246tNt.com>, sl@bplan-gmbh.de,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------030204080309010709010900
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Benjamin Herrenschmidt wrote:

> Now, in addition to that, we have another issue I haven't spotted
> before, but it might be worth considering:
> 
> Do we actually want the sdma interrupts handled there ? Because if you
> look closely, the SDMA is basically a cascaded interrupt controller. It
> hangs of per interrupt 0 :)

I know. I already spot this point (IRQ as far as I remenber and in 
private mails) and I got no answer so I assumed it was ok like I did. 
It's also really simplier and easier to add SDMA has another irq_chip.
Keep is simple ;-)

> Thus we could simply remove the code for it from that driver and
> implement it as as separate controller with a separate interrupt domain.
> I know you won't like that idea because it means having a different
> interrupt tree but it's worth having the discussion.
> 

The device tree won't change anyway...

I'll submit a new buch of patches pretty soon. Maybe the final version.

"On y est presque !" ;-)

Regards


--------------030204080309010709010900
Content-Type: text/x-vcard; charset=utf-8;
 name="nd.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="nd.vcf"

begin:vcard
fn:Nicolas DET ( bplan GmbH )
n:DET;Nicolas
org:bplan GmbH
adr:;;;;;;Germany
email;internet:nd@bplan-gmbh.de
title:Software Entwicklung
tel;work:+49 6171 9187 - 31
x-mozilla-html:FALSE
url:http://www.bplan-gmbh.de
version:2.1
end:vcard


--------------030204080309010709010900--

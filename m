Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 5D485DDDF5
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Sep 2007 06:19:28 +1000 (EST)
To: "Nicholas Hickman" <nhickman@dtechlabs.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: SPI driver?
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 11 Sep 2007 11:50:56 EDT."
	<8140AAF341CC904BA92C3D6A5A1909782F0D4F@ditech-1.ditechllc.com>
Date: Tue, 11 Sep 2007 22:19:26 +0200
Sender: wd@denx.de
Message-Id: <20070911201926.2B0EA247CE@gemini.denx.de>
Cc: Hesam.Kohanteb@Sun.COM, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <8140AAF341CC904BA92C3D6A5A1909782F0D4F@ditech-1.ditechllc.com> you wrote:
> I am also in search of this, or some information about one.  Please let
> me know if you find anything.
> 
> I ran across an existing platform that used an mpc8270.  During boot up
> it displayed:
> [   17.828513] SPIDriver: module license 'Proprietary' taints kernel.
> [   17.865052] CPM SPI Driver: $Revision: 1.0 $ wd@denx.de
> 
> I have been all over denx and have not been able to find it.  This
> particular system used the SPI for a DSP chip. 

Probably somebody copied and modified a  driver  they  found  in  our
trees. We release all such code under GPL...

You can find SPI driver code in our old linuxppc_2_4_devel tree,  but
this  does  not  include  support  for  MPC82xx; and then there is an
ancient (5+ years) 82xx SPI driver in our  linux-2.4  (2.4.4)  kernel
tree.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Thought for the day: What if there were no hypothetical situations?

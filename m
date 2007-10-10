Return-Path: <one@ecom.com>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.191])
	by ozlabs.org (Postfix) with ESMTP id 0A5A7DE02A
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2007 06:39:47 +1000 (EST)
Received: by rv-out-0910.google.com with SMTP id c27so268646rvf
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Oct 2007 13:39:46 -0700 (PDT)
Message-ID: <f6c0dc290710101339t30a15881t3ffbe02324006b28@mail.gmail.com>
Date: Wed, 10 Oct 2007 14:39:45 -0600
From: "Eno 3 Compton" <one@ecom.com>
To: linuxppc-dev@ozlabs.org
Subject: irq identification has changed from 2.6.10 to 2.6.23. an explanation
	is requested
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_17908_17141708.1192048785099"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_17908_17141708.1192048785099
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Dear All,

I had a driver working under 2.6.10 on a mpc8248. The kernel got changed
under me to 2.6.23. Now, when I call request_irq with SIU_INT_IRQ5, which is
defined in asm-powerpc/irq.h, and once compiled and worked properly, I get
compilation errors. The compiler can't find the symbol definition because
CONFIG_PPC_MERGE  is defined. I suspect the kernel guys have migrated things
to a new arrangement, which I've been unable to discern.

An explanation or advice on where to find information about this would be
hugely appreciated.

Eno Compton

------=_Part_17908_17141708.1192048785099
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Dear All,<br><br>I had a driver working under 2.6.10 on a mpc8248. The kernel got changed under me to 2.6.23. Now, when I call request_irq with SIU_INT_IRQ5, which is defined in asm-powerpc/irq.h, and once compiled and worked properly, I get compilation errors. The compiler can&#39;t find the symbol definition because CONFIG_PPC_MERGE&nbsp; is defined. I suspect the kernel guys have migrated things to a new arrangement, which I&#39;ve been unable to discern.
<br><br>An explanation or advice on where to find information about this would be hugely appreciated.<br><br>Eno Compton<br>

------=_Part_17908_17141708.1192048785099--

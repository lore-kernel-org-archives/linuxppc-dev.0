Return-Path: <FENKES@de.ibm.com>
Received: from mtagate2.de.ibm.com (mtagate2.de.ibm.com [195.212.29.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate2.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C8BD6DDEC7
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Mar 2007 04:40:41 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate2.de.ibm.com (8.13.8/8.13.8) with ESMTP id l29HebYP080622
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Mar 2007 17:40:37 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.3) with
	ESMTP id l29HeanZ1851422
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Mar 2007 18:40:36 +0100
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l29Hea7E010564
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Mar 2007 18:40:36 +0100
In-Reply-To: <1173217902.15589.33.camel@sinatra.austin.ibm.com>
To: John Rose <johnrose@austin.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] ibmebus: dynamic addiiton/removal of adapters, uevent,
	root device based on struct device
From: Joachim Fenkes <FENKES@de.ibm.com>
Message-ID: <OFAC7B9901.69441F4F-ONC1257299.005F175A-C1257299.006117C1@de.ibm.com>
Date: Fri, 9 Mar 2007 18:40:35 +0100
Content-Type: text/plain; charset="US-ASCII"
Cc: Paul Mackerras <pmac@au1.ibm.com>,
	Stefan Roscher <stefan.roscher@de.ibm.com>,
	lkml <linux-kernel@vger.kernel.org>,
	External List <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
	Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>,
	Me Notes <johnrose@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

John Rose <johnrose@austin.ibm.com> wrote on 06.03.2007 22:51:42:

> We are seeing several build errors when attempting to apply this to
> 2.6.21-rc2:

Hot Damn! I did my test compiles with gcc 3.3, and you obviously compiled 
with gcc 4.1 - I only got a warning where you got an error, and that 
warning escaped me. Sorry about that.

I fixed the error and all warnings and will post a fresh set of patches 
right after this reply. If you could give the new patch another go and ack 
it if it works, I would be delighted! =)

Thanks for pointing this out!
  Joachim

---
Joachim Fenkes  --  eHCA Linux Driver Developer and Hardware Tamer
IBM Deutschland Entwicklung GmbH  --  Dept. 3627 (I/O Firmware Dev. 2)
Schoenaicher Strasse 220  --  71032 Boeblingen  --  Germany
eMail: fenkes@de.ibm.com  --  Phone: +49 7031 16 1239 

Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id A01F3679F7
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 21 Apr 2006 23:03:00 +1000 (EST)
Received: from vitb.ru.mvista.com ([10.150.0.9])
	by buildserver.ru.mvista.com (8.11.6/8.11.6) with ESMTP id k3LD2vs24442
	for <linuxppc-embedded@ozlabs.org>; Fri, 21 Apr 2006 18:02:57 +0500
Date: Fri, 21 Apr 2006 17:03:06 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: USB-Hostcontroller-Support for MPC875
Message-ID: <20060421170306.53d2d4c9@vitb.ru.mvista.com>
In-Reply-To: <4448D6B7.40509@cs.fau.de>
References: <4448D6B7.40509@cs.fau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, 21 Apr 2006 14:57:27 +0200
Josef Angermeier <Josef.Angermeier@informatik.uni-erlangen.de> wrote:

> 
> Hello,
> 
> I'd like to make use of the MP875 internal USB-Hostcontroller on my 
> custome board. Such support is not included in official kernel releases, 
> but theres exists a usbhost-for-mpc8xx patch from brad parker for the 
> 2.4 kernel series. Did ever someone use that one with an MPC875 ?
> 

Brad Parker's approach is the only I am aware of, and I had no success to bring hci up on my 8xx with those 
sources. 

-- 
Sincerely, 
Vitaly

Return-Path: <srinivasa@in.ibm.com>
Received: from ausmtp05.au.ibm.com (ausmtp05.au.ibm.com [202.81.18.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp05.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BED7D67BC1
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Nov 2006 20:45:06 +1100 (EST)
Received: from sd0208e0.au.ibm.com (d23rh904.au.ibm.com [202.81.18.202])
	by ausmtp05.au.ibm.com (8.13.8/8.13.6) with ESMTP id kAOLkkYo5279854
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Nov 2006 20:46:46 -0100
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.250.243])
	by sd0208e0.au.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kAO9m8cJ133934
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Nov 2006 20:48:18 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kAO9ieus003883
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Nov 2006 20:44:40 +1100
Message-ID: <4566D172.1040505@in.ibm.com>
Date: Fri, 24 Nov 2006 16:33:14 +0530
From: Srinivasa Ds <srinivasa@in.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] Reorganise and then fixup the pseries cpu hotplug code
References: <20061123021132.B03F767C18@ozlabs.org>
In-Reply-To: <20061123021132.B03F767C18@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: ego@in.ibm.com, linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>, ntl@pobox.com,
	linas@boardhead.austin.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michael Ellerman wrote:
>
> Updated to printk if we can't find the RTAS tokens, and to remove the
> comment about drslot_chrp_cpu etc.
>
> Linas, Srinivasa, can you test that this addresses the problems you
> were seeing. It should, but it'd be good if you could test it.
>   
 As I was busy this week, I didn't  test your patch. I will do that on 
monday.

Thanks
 Srinivasa DS

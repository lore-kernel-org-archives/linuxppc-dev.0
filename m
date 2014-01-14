Return-Path: <slpratt@austin.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 857362C0082
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jan 2014 01:36:25 +1100 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <slpratt@austin.ibm.com>;
 Tue, 14 Jan 2014 07:36:22 -0700
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id C3BA56E8048
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jan 2014 09:36:15 -0500 (EST)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp23032.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s0EEaJNJ10092840
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jan 2014 14:36:19 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0EEaJHm026523
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jan 2014 09:36:19 -0500
Received: from [9.48.125.193] (sig-9-48-125-193.mts.ibm.com [9.48.125.193])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 s0EEaGep026363
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jan 2014 09:36:18 -0500
Message-ID: <52D54B60.4090807@austin.ibm.com>
Date: Tue, 14 Jan 2014 08:36:16 -0600
From: Steven Pratt <slpratt@austin.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: Disable sleep states on P7+
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I am looking for info on when and how we are able to disable power saving features of current (P7, P7+) chips in order to reduce latency. This is often done in latency sensitive applications when power consumption is not an issue. On Intel boxes we can disable P-state frequency changes as well as disabling C-State or sleep state changes. In fact we can control how deep a sleep the processor can go into.  I know we have control Dynamic Processor Scaling and Idle Power Savings, but what states do these really affect?  Can I really disable Nap mode of a processor? If so how?  Can I disable even the lightest winkle mode?  Looking for current information (read RHEL 6 and SLES11), future changes are interesting.

Steve

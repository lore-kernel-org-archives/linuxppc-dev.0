Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7E01C67B4B
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 15 Feb 2006 09:01:14 +1100 (EST)
Date: Tue, 14 Feb 2006 15:52:18 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: "dibacco@inwind.it" <dibacco@inwind.it>
Subject: Re: no sys folder under /proc
In-Reply-To: <IUP6CT$AB62363556CBF94AF9C57C018B7462E3@libero.it>
Message-ID: <Pine.LNX.4.44.0602141550470.2609-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, 14 Feb 2006, dibacco@inwind.it wrote:

> Hi,
> 
> I don't find the directory sys under /proc. Someone knows why?
> Furthermore, printk from a driver are not found in /var/log/messages, what could be missing?

If I were to guess, the first issue maybe due to your kernel not having 
something built into it like SYSCTL, but I'm only guessing thst SYSCTL is 
related to /proc/sys.

The second requires you having something like syslog running.

- k

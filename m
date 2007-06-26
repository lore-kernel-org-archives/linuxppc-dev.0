Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9CA7FDDF0B
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Jun 2007 11:55:58 +1000 (EST)
Subject: Re: [PATCH v2] Fix VDSO gettimeofday() when called with NULL
	struct timeval.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Tony Breeds <tony@bakeyournoodle.com>
In-Reply-To: <20070625235032.GH9768@bakeyournoodle.com>
References: <20070625105836.GE9768@bakeyournoodle.com>
	<20070625235032.GH9768@bakeyournoodle.com>
Content-Type: text/plain
Date: Tue, 26 Jun 2007 11:55:47 +1000
Message-Id: <1182822947.5521.145.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: LinuxPPC-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-06-26 at 09:50 +1000, Tony Breeds wrote:
> Updated to include feedback from Ben and Segher, also reposition the
> compare in the 64bit VDSO to catch all the references to tv.
> 
> From: Tony Breeds <tony@bakeyournoodle.com>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

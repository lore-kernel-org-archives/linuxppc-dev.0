Return-Path: <felix@embedded-sol.com>
Received: from sh78.surpasshosting.com (sh78.surpasshosting.com [72.29.64.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9AFFF1007DD
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  5 Mar 2011 10:08:29 +1100 (EST)
Message-ID: <4D7167A5.1090909@embedded-sol.com>
Date: Sat, 05 Mar 2011 00:28:53 +0200
From: Felix Radensky <felix@embedded-sol.com>
MIME-Version: 1.0
To: "Ira W. Snyder" <iws@ovro.caltech.edu>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 0/9] fsldma: lockup fixes
References: <1299174901-16762-1-git-send-email-iws@ovro.caltech.edu>
In-Reply-To: <1299174901-16762-1-git-send-email-iws@ovro.caltech.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ira,

I've successfully tested this version on P2020RDB,
with 10 threads per channel, 100000 iterations per
thread.

Tested-by: Felix Radensky <felix@embedded-sol.com>

Felix.

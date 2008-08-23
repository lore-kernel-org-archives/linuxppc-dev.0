Return-Path: <kevdig@hypersurf.com>
Received: from smtpauth.hypersurf.com (smtpauth.hypersurf.com [209.237.0.8])
	by ozlabs.org (Postfix) with ESMTP id 32A8BDDEF9
	for <linuxppc-dev@ozlabs.org>; Sun, 24 Aug 2008 04:30:09 +1000 (EST)
Message-ID: <48B0569E.6030907@hypersurf.com>
Date: Sat, 23 Aug 2008 11:27:42 -0700
From: Kevin Diggs <kevdig@hypersurf.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: compile testing:  cpufreq stats driver?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

	When I tried building my cpufreq driver into the kernel, the
cpufreq stats driver quit working? Anyone know if I screwed something up?
Or is this normal (2.6.26)?

	Also, I thought, apparently incorrectly, That module parameters
became boot parameters when the module was built in to the kernel?

kevin

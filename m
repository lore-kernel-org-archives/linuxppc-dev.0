Return-Path: <pochini@shiny.it>
Received: from smtp-out113.alice.it (smtp-out113.alice.it [85.37.17.113])
	by ozlabs.org (Postfix) with ESMTP id 70341B6F2B
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 12 Nov 2009 08:22:20 +1100 (EST)
Date: Wed, 11 Nov 2009 22:14:20 +0100
From: Giuliano Pochini <pochini@shiny.it>
To: linuxppc-dev@lists.ozlabs.org
Subject: suspend to ram on pmac ?
Message-ID: <20091111221420.4d303652@Jay>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


I have a pmac G4 MDD. Is suspend to ram supported ? I enabled all pm
related kernel options I could find, but:

# ls -la /sys/power/
total 0
drwxr-xr-x  2 root root    0 Nov  9 19:33 .
drwxr-xr-x 12 root root    0 Nov  9 19:32 ..
-rw-r--r--  1 root root 4096 Nov  9 19:33 pm_test
-rw-r--r--  1 root root 4096 Nov  9 19:33 state
# cat pm_test
[none] core processors platform devices freezer
# cat state
#


I do not actually need STR. I have to test suspend/resume support for a
driver, so I need at least a working pm_test at devices level.


-- 
Giuliano.

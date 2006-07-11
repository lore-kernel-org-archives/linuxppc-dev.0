Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id DC5CF67B54
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 11 Jul 2006 22:32:13 +1000 (EST)
Message-ID: <44B39284.60505@ru.mvista.com>
Date: Tue, 11 Jul 2006 15:59:00 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: rahul <rahul.theraja@gmail.com>
Subject: Re: regarding lspci
References: <44B36F85.3010703@gmail.com>	<200607111147.21820.claus.gindhart@kontron-modular.com>
	<44B381B7.1030500@gmail.com>
In-Reply-To: <44B381B7.1030500@gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello.

rahul wrote:

> I am facing some problem in applying the patch.

> I have copied the pacth to a file "patch-pciutils"

> [root@localhost pciutils-2.1.11]# file patch-pciutils
> patch-pciutils: 'diff' output text
> [root@localhost pciutils-2.1.11]#
> when i gave the command :
> [root@localhost pciutils-2.1.11]# patch -p1 patch-pciutils
> .
> .
> Nothing happens even after 3/4 minutes...so i am stopping it by ctrl+c.
> None of the files are edited.

    No wonder, patch(1) expects the patch to be fed thru stdin, so you should 
have typed:

patch -p1 < patch-pciutils

> Thanks & Regards
> Rahul

WBR, Sergei

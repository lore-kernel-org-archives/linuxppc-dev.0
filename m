Return-Path: <srs0=r+d+=lm=emerson.com=sachin.gosavi@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 420ms24wJMzF09c
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Aug 2018 23:37:42 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 420ms23qrdz8w0l
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Aug 2018 23:37:42 +1000 (AEST)
Received: from n7.nabble.com (n7.nabble.com [162.253.133.57])
 by ozlabs.org (Postfix) with ESMTP id 420ms21Hnmz9s1x
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Aug 2018 23:37:41 +1000 (AEST)
Received: from n7.nabble.com (localhost [127.0.0.1])
 by n7.nabble.com (Postfix) with ESMTP id CC32A6A175B7
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Aug 2018 06:37:39 -0700 (MST)
Date: Wed, 29 Aug 2018 06:37:39 -0700 (MST)
From: sgosavi1 <Sachin.Gosavi@emerson.com>
To: linuxppc-dev@ozlabs.org
Message-ID: <1535549859780-0.post@n7.nabble.com>
In-Reply-To: <1fd6324f-515b-4e9e-a942-c606ad919dec@c-s.fr>
References: <1535541276673-0.post@n7.nabble.com>
 <1fd6324f-515b-4e9e-a942-c606ad919dec@c-s.fr>
Subject: Re: Not able to boot cuImage for the target board with MPC8270
 processor
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Yes, both these config options are enabled as you can see from the below
details from my .config file.

CONFIG_PPC_EARLY_DEBUG=y
CONFIG_PPC_EARLY_DEBUG_CPM=y
# CONFIG_PPC_EARLY_DEBUG_MEMCONS is not set
CONFIG_PPC_EARLY_DEBUG_CPM_ADDR=0x11a80



--
Sent from: http://linuxppc.10917.n7.nabble.com/linuxppc-dev-f3.html

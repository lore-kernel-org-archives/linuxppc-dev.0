Return-Path: <dhowells@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id 288D4B7D24
	for <linuxppc-dev@ozlabs.org>; Wed,  5 May 2010 00:44:17 +1000 (EST)
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1272723382-19470-2-git-send-email-orenl@cs.columbia.edu>
References: <1272723382-19470-2-git-send-email-orenl@cs.columbia.edu>
	<1272723382-19470-1-git-send-email-orenl@cs.columbia.edu>
To: Oren Laadan <orenl@cs.columbia.edu>
Subject: Re: [PATCH v21 001/100] eclone (1/11): Factor out code to allocate
	pidmap page
Date: Tue, 04 May 2010 15:43:13 +0100
Message-ID: <3803.1272984193@redhat.com>
Sender: dhowells@redhat.com
Cc: linux-s390@vger.kernel.org, linux-api@vger.kernel.org,
	containers@lists.linux-foundation.org, x86@kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Matt Helsley <matthltc@us.ibm.com>, Serge Hallyn <serue@us.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
	Pavel Emelyanov <xemul@openvz.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


With a huge patch series like this, can you post a cover note at the front
(usually patch 0) saying what the point of the whole series is?

David

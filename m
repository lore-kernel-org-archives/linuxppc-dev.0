Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0764AC4345F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2024 13:57:37 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=gxbDmDtH;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VP3bN3H1Zz3dXK
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2024 23:57:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=gxbDmDtH;
	dkim-atps=neutral
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VP3ZX1ZjHz3cS3
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2024 23:56:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1713880607;
	bh=CHtOdwbj0E1GvwNkXmOfZvz8pKIWj92NEKclpPh6Nas=;
	h=From:To:Cc:Subject:Date:From;
	b=gxbDmDtHv8CHQGC16MwRvxY5H/eQJEZ1uUUgkCA/31tRoQMst3mllrY1L96An4W8z
	 ZgjxurB7hIx+CtkxSJDlLfsLTdn/P1yplRiwmzmxV9JwOG9JZ2/WmxhqOH01VHAZ2T
	 Xu1m+u1oHdw7sgbgSBu7lL9GAVZP/Y3beq5ooL3aox888yI+yo1X8shY49JKWqEkZ7
	 +gSfoW3JSxL9xF9Ch0lFhJROyiJy741/A4jxtn1EDV6AQhd0gHlWiRWN1YVB1XNyMl
	 9Hvi3NtvspG1aywuM84oL3s6QPy2ihc8nuZPuhlVhnsvv8YVLxqoEiaxt7RaGclVK6
	 ioTNNK6Xg5/Vw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VP3ZP3GqJz4wby;
	Tue, 23 Apr 2024 23:56:45 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Please add powerpc topic/kdump-hotplug branch to linux-next
Date: Tue, 23 Apr 2024 23:56:42 +1000
Message-ID: <87bk60ji79.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: kexec@lists.infradead.org, Linux Next Mailing List <linux-next@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, bhe@redhat.com, sourabhjain@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Stephen,

Can you please add the topic/kdump-hotplug branch of the powerpc tree to
linux-next. It contains a series that touches generic kexec code as well
as x86 and powerpc code.

The hope is to have to get it merged for v6.10, so it should go along
with the powerpc next branch in the merge order.

https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git/log/?h=topic/kdump-hotplug

cheers

Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 83E05DDE9C
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jan 2008 11:27:31 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 3/8] pseries: phyp dump: reserve-release proof-of-concept
Date: Tue, 8 Jan 2008 01:26:50 +0100
References: <4782C1A8.3050804@austin.ibm.com>
In-Reply-To: <4782C1A8.3050804@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200801080126.51897.arnd@arndb.de>
Cc: mahuja@us.ibm.com, lkessler@us.ibm.com, linasvepstas@gmail.com,
	strosake@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 08 January 2008, Manish Ahuja wrote:

> Initial patch for reserving memory in early boot, and freeing it later.
> If the previous boot had ended with a crash, the reserved memory would contain
> a copy of the crashed kernel data.
> 
> Signed-off-by: Manish Ahuja <mahuja@us.ibm.com>
> Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

I think the signed-off-by chain needs to be modified. The way it appears,
you handled the patch first, then sent it to Linas, who forwarded it
to whoever will take the patches from the list.

This obviously isn't true, since you are actually the one who is sending
out the patches. Moreover, I believe that the linas@austin.ibm.com
address is now dead, and shouldn't be used for this any more.

So, depending on which of you two wrote the majority of a patch, I think
it should be either

| Signed-off-by: Manish Ahuja <mahuja@us.ibm.com>
| Acked-by: Linas Vepstas <linasvepstas@gmail.com>

or 

| From: Linas Vepstas <linasvepstas@gmail.com>
| Signed-off-by: Manish Ahuja <mahuja@us.ibm.com>

	Arnd <><

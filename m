Return-Path: <michael@evidence.eu.com>
Received: from sssup.it (ms01.sssup.it [193.205.80.99])
	by ozlabs.org (Postfix) with ESMTP id A93A3B7128
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Jan 2011 06:23:45 +1100 (EST)
Message-ID: <4D24B725.2020300@evidence.eu.com>
Date: Wed, 05 Jan 2011 19:23:33 +0100
From: michael <michael@evidence.eu.com>
MIME-Version: 1.0
To: Rafael Beims <rbeims@gmail.com>
Subject: Re: mpc880 linux-2.6.32 slow running processes
References: <AANLkTin5XTnDEu1BJUOeF0UWtfEpotW5Bq__i8g6U05h@mail.gmail.com>
In-Reply-To: <AANLkTin5XTnDEu1BJUOeF0UWtfEpotW5Bq__i8g6U05h@mail.gmail.com>
Content-Type: multipart/mixed; boundary="------------030804090904020305070703"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------030804090904020305070703
Content-Type: multipart/alternative;
 boundary="------------070606060406000603090200"


--------------070606060406000603090200
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi

On 01/05/2011 07:09 PM, Rafael Beims wrote:
> Hello all,
> I'm working with an MPC880 board that is supposed to run linux-2.6.32. After
> some work, I could get the kernel up and running, mounting a rootfs via
> NFS.
> The problem that I'm facing now is that when I try to run any process (may
> be an ls, cat, or whatever), the response of the process is *very* slow
> (something like 10 to 20 seconds for a ls).
> Monitoring the network packets, I can see that the nfs protocol is exchanged
> just fine, but at some time it simply stops, starting again with a request
> from the board several seconds later.
> I'm thinking that the processor is running (something, I don't know what)
> for all this time before I can see requests coming from the board again. I
> pinged the board from the PC and during all this I can see the packets being
> answered.
>
Can you try this patch?

> My question to all is, did anyone see something like this already? Besides
> that, what is the status of the linux kernel support for the 8xx platform?
> Is it being actively tested / used today? I ask this because it seems that
> all the information on the internet very aged (forum discussions from 2005
> and below mostly).
>
> Is there something that I can do to try to narrow the cause of the problem?
>
> Anyway, any help would be truly appreciated. Please excuse me if this is not
> the right place to ask this too.
>
> Thanks and best regards,
> Rafael Beims
> rbeims@gmail.com
> (41) 8873-7565
> "What I hear, I forget. What I see, I remember. And what I do, I
> understand."
> - Chinese Proverb
>
>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev


--------------070606060406000603090200
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#ffffff">
    <tt>Hi<br>
      <br>
    </tt>On 01/05/2011 07:09 PM, Rafael Beims wrote:
    <blockquote
      cite="mid:AANLkTin5XTnDEu1BJUOeF0UWtfEpotW5Bq__i8g6U05h@mail.gmail.com"
      type="cite">
      <pre wrap="">Hello all,
I'm working with an MPC880 board that is supposed to run linux-2.6.32. After
some work, I could get the kernel up and running, mounting a rootfs via
NFS.
The problem that I'm facing now is that when I try to run any process (may
be an ls, cat, or whatever), the response of the process is *very* slow
(something like 10 to 20 seconds for a ls).
Monitoring the network packets, I can see that the nfs protocol is exchanged
just fine, but at some time it simply stops, starting again with a request
from the board several seconds later.
I'm thinking that the processor is running (something, I don't know what)
for all this time before I can see requests coming from the board again. I
pinged the board from the PC and during all this I can see the packets being
answered.

</pre>
    </blockquote>
    <tt>Can you try this patch?<br>
      <br>
    </tt>
    <blockquote
      cite="mid:AANLkTin5XTnDEu1BJUOeF0UWtfEpotW5Bq__i8g6U05h@mail.gmail.com"
      type="cite">
      <pre wrap="">My question to all is, did anyone see something like this already? Besides
that, what is the status of the linux kernel support for the 8xx platform?
Is it being actively tested / used today? I ask this because it seems that
all the information on the internet very aged (forum discussions from 2005
and below mostly).

Is there something that I can do to try to narrow the cause of the problem?

Anyway, any help would be truly appreciated. Please excuse me if this is not
the right place to ask this too.

Thanks and best regards,
Rafael Beims
<a class="moz-txt-link-abbreviated" href="mailto:rbeims@gmail.com">rbeims@gmail.com</a>
(41) 8873-7565
"What I hear, I forget. What I see, I remember. And what I do, I
understand."
- Chinese Proverb

</pre>
      <pre wrap="">
<fieldset class="mimeAttachmentHeader"></fieldset>
_______________________________________________
Linuxppc-dev mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Linuxppc-dev@lists.ozlabs.org">Linuxppc-dev@lists.ozlabs.org</a>
<a class="moz-txt-link-freetext" href="https://lists.ozlabs.org/listinfo/linuxppc-dev">https://lists.ozlabs.org/listinfo/linuxppc-dev</a></pre>
    </blockquote>
    <br>
  </body>
</html>

--------------070606060406000603090200--

--------------030804090904020305070703
Content-Type: text/x-diff;
 name="slowdown.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="slowdown.patch"

diff --git a/arch/powerpc/include/asm/pte-8xx.h b/arch/powerpc/include/asm/pte-8xx.h
index dd5ea95..cb67076 100644
--- a/arch/powerpc/include/asm/pte-8xx.h
+++ b/arch/powerpc/include/asm/pte-8xx.h
@@ -32,7 +32,7 @@
 #define _PAGE_FILE	0x0002	/* when !present: nonlinear file mapping */
 #define _PAGE_NO_CACHE	0x0002	/* I: cache inhibit */
 #define _PAGE_SHARED	0x0004	/* No ASID (context) compare */
-#define _PAGE_SPECIAL	0x0008	/* SW entry, forced to 0 by the TLB miss */
+#define _PAGE_SPECIAL	0x0000	/* SW entry, forced to 0 by the TLB miss */
 
 /* These five software bits must be masked out when the entry is loaded
  * into the TLB.
diff --git a/arch/powerpc/include/asm/pte-common.h b/arch/powerpc/include/asm/pte-common.h
index f2b3701..3b88376 100644
--- a/arch/powerpc/include/asm/pte-common.h
+++ b/arch/powerpc/include/asm/pte-common.h
@@ -176,5 +176,7 @@ extern unsigned long bad_call_to_PMD_PAGE_SIZE(void);
 #define HAVE_PAGE_AGP
 
 /* Advertise support for _PAGE_SPECIAL */
+#if _PAGE_SPECIAL != 0
 #define __HAVE_ARCH_PTE_SPECIAL
+#endif
 
diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
index 5304093..1da03a8 100644
--- a/arch/powerpc/mm/pgtable.c
+++ b/arch/powerpc/mm/pgtable.c
@@ -173,21 +173,29 @@ static pte_t set_pte_filter(pte_t pte, unsigned long addr)
 	pte = __pte(pte_val(pte) & ~_PAGE_HPTEFLAGS);
 	if (pte_looks_normal(pte) && !(cpu_has_feature(CPU_FTR_COHERENT_ICACHE) ||
 				       cpu_has_feature(CPU_FTR_NOEXECUTE))) {
-		struct page *pg = maybe_pte_to_page(pte);
-		if (!pg)
+		unsigned long pfn = pte_pfn(pte);
+		struct page *pg;
+
+		if (unlikely(!pfn_valid(pfn)))
 			return pte;
-		if (!test_bit(PG_arch_1, &pg->flags)) {
+
+		pg = pfn_to_page(pfn);
 #ifdef CONFIG_8xx
-			/* On 8xx, cache control instructions (particularly
-			 * "dcbst" from flush_dcache_icache) fault as write
-			 * operation if there is an unpopulated TLB entry
-			 * for the address in question. To workaround that,
-			 * we invalidate the TLB here, thus avoiding dcbst
-			 * misbehaviour.
-			 */
-			/* 8xx doesn't care about PID, size or ind args */
-			_tlbil_va(addr, 0, 0, 0);
+		/* On 8xx, cache control instructions (particularly
+		 * "dcbst" from flush_dcache_icache) fault as write
+		 * operation if there is an unpopulated TLB entry
+		 * for the address in question. To workaround that,
+		 * we invalidate the TLB here, thus avoiding dcbst
+		 * misbehaviour.
+		 */
+		/* 8xx doesn't care about PID, size or ind args */
+		_tlbil_va(addr, 0, 0, 0);
 #endif /* CONFIG_8xx */
+
+		if (!pg)
+			return pte;
+
+		if (!PageReserved(pg) && !test_bit(PG_arch_1, &pg->flags)) {
 			flush_dcache_icache_page(pg);
 			set_bit(PG_arch_1, &pg->flags);
 		}

--------------030804090904020305070703--

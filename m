Return-Path: <walken@google.com>
Received: from smtp-out.google.com (smtp-out.google.com [74.125.121.67])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9E933B6FA7
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Mar 2011 00:14:46 +1100 (EST)
Received: from wpaz21.hot.corp.google.com (wpaz21.hot.corp.google.com
	[172.24.198.85]) by smtp-out.google.com with ESMTP id p29DEaGk011474
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Mar 2011 05:14:40 -0800
Received: from qyg14 (qyg14.prod.google.com [10.241.82.142])
	by wpaz21.hot.corp.google.com with ESMTP id p29D9AxY000638
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Mar 2011 05:09:10 -0800
Received: by qyg14 with SMTP id 14so400214qyg.19
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 09 Mar 2011 05:09:10 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1299630721-4337-1-git-send-email-wilsons@start.ca>
References: <1299630721-4337-1-git-send-email-wilsons@start.ca>
Date: Wed, 9 Mar 2011 05:09:09 -0800
Message-ID: <AANLkTikTEi8uKeCfPLoenNx9g6fLyAqNqfVdR=4KzNB3@mail.gmail.com>
Subject: Re: [PATCH 0/5] make *_gate_vma accept mm_struct instead of
	task_struct
From: Michel Lespinasse <walken@google.com>
To: Stephen Wilson <wilsons@start.ca>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-s390@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
	Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org,
	x86@kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, "H. Peter Anvin" <hpa@zytor.com>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com,
	Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 8, 2011 at 4:31 PM, Stephen Wilson <wilsons@start.ca> wrote:
> Morally, the question of whether an address lies in a gate vma should be =
asked
> with respect to an mm, not a particular task.
>
> Practically, dropping the dependency on task_struct will help make curren=
t and
> future operations on mm's more flexible and convenient. =A0In particular,=
 it
> allows some code paths to avoid the need to hold task_lock.

Reviewed-by: Michel Lespinasse <walken@google.com>

May I suggest ia32_compat instead of just compat for the flag name ?

--=20
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.

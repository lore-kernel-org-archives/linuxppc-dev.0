Return-Path: <prodyuth@gmail.com>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.152])
	by ozlabs.org (Postfix) with ESMTP id 17343DE27B
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jan 2009 06:02:47 +1100 (EST)
Received: by fg-out-1718.google.com with SMTP id d23so4649577fga.39
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Jan 2009 11:02:45 -0800 (PST)
Message-ID: <49c0ff980901121102t46b1e50cna6fbd333142485b7@mail.gmail.com>
Date: Mon, 12 Jan 2009 11:02:45 -0800
From: "prodyut hazarika" <prodyuth@gmail.com>
To: "Yuri Tikhonov" <yur@emcraft.com>
Subject: Re: [PATCH][v3] powerpc 44x: support for 256KB PAGE_SIZE
In-Reply-To: <200901112142.31003.yur@emcraft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
References: <200901112142.31003.yur@emcraft.com>
Cc: wd@denx.de, yanok@emcraft.com, miltonm@bga.com, linuxppc-dev@ozlabs.org,
	paulus@samba.org, dzu@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Jan 11, 2009 at 10:42 AM, Yuri Tikhonov <yur@emcraft.com> wrote:
>
> This patch adds support for 256KB pages on ppc44x-based boards.
>

Hi Yuri,
Do you still need the mm/shmem.c patch to avoid division by zero? I
looked at the mm/shmem.c latest git code, and I see that it doesn't
have the needed patch for 256KB page.
I think another option would be to make 256KB compile only if CONFIG_SHMEM=n

Thanks
Prodyut

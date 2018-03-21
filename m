Return-Path: <martin.petersen@oracle.com>
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4064vM51z4zF1w6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2018 09:57:35 +1100 (AEDT)
To: Joe Perches <joe@perches.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Will Deacon
 <will.deacon@arm.com>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng
 <boqun.feng@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len
 Brown <lenb@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Sathya Prakash
 <sathya.prakash@broadcom.com>, Chaitra P B <chaitra.basappa@broadcom.com>,
 Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>,
 Manish Chopra <manish.chopra@cavium.com>,
 Rahul Verma <rahul.verma@cavium.com>, Dept-GELinuxNICDev@cavium.com,
 QCA ath9k Development <ath9k-devel@qca.qualcomm.com>, Corentin Chary
 <corentin.chary@gmail.com>, Darren Hart <dvhart@infradead.org>, Andy
 Shevchenko <andy@infradead.org>, Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>, Adaptec OEM Raid
 Solutions <aacraid@adaptec.com>, "James E.J. Bottomley"
 <jejb@linux.vnet.ibm.com>, "Martin K. Petersen"
 <martin.petersen@oracle.com>, Matthew Wilcox <matthew@wil.cx>, Jeff
 Layton <jlayton@kernel.org>, "J. Bruce Fields" <bfields@fieldses.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
 "Darrick J. Wong" <darrick.wong@oracle.com>,
 linux-xfs@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
 Eric Paris <eparis@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
 Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>,
 Jiri Kosina <trivial@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
 Alex Deucher <alexander.deucher@amd.com>, Christian
 =?utf-8?Q?K=C3=B6nig?= <christian.koenig@amd.com>, "David \(ChunMing\)
 Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Mauro
 Carvalho Chehab <mchehab@kernel.org>,
 Kalle Valo <kvalo@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
 MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
 netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
 acpi4asus-user@lists.sourceforge.net,
 platform-driver-x86@vger.kernel.org, linux-rtc@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
 linux-audit@redhat.com, alsa-devel@alsa-project.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [trivial PATCH V2] treewide: Align function definition open/close
 braces
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <5ccbbf083e26bddfb4ea4f819ed62347ce266f39.1521669820.git.joe@perches.com>
Date: Wed, 21 Mar 2018 18:53:46 -0400
In-Reply-To: <5ccbbf083e26bddfb4ea4f819ed62347ce266f39.1521669820.git.joe@perches.com>
 (Joe Perches's message of "Wed, 21 Mar 2018 15:09:32 -0700")
Message-ID: <yq1370trqf9.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Joe,

> Some functions definitions have either the initial open brace and/or
> the closing brace outside of column 1.
>
> Move those braces to column 1.

drivers/scsi and drivers/message/fusion parts look fine.

Acked-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering

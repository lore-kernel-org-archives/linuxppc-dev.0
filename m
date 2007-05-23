Return-Path: <matvejchikov@gmail.com>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.233])
	by ozlabs.org (Postfix) with ESMTP id 4AA4DDDDFE
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 May 2007 05:47:49 +1000 (EST)
Received: by nz-out-0506.google.com with SMTP id v1so304132nzb
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 May 2007 12:47:45 -0700 (PDT)
Message-ID: <8496f91a0705231247l2adfe99ar5f77ae35d1ac9df5@mail.gmail.com>
Date: Wed, 23 May 2007 23:47:45 +0400
From: "Matvejchikov Ilya" <matvejchikov@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: FCC receiver BSY errors
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Reply-To: matvejchikov@gmail.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all!

I use fs_enet driver on mpc8260. Sometimes at heavy uploading the
receiver busy error arises (FCC_ENET_BSY). After that the receiver
stops working. Only restart() function helps. Has anybody come across
such a problem? Is it possible that there is an erratum in mpc82xx?

Thanks.

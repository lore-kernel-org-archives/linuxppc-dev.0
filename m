Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.168])
	by ozlabs.org (Postfix) with ESMTP id CD678DDEE4
	for <linuxppc-dev@ozlabs.org>; Sun,  1 Apr 2007 03:06:19 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so1057468ugf
	for <linuxppc-dev@ozlabs.org>; Sat, 31 Mar 2007 10:06:18 -0700 (PDT)
Message-ID: <528646bc0703311006l6cf684a1o584b9cd6adb29a96@mail.gmail.com>
Date: Sat, 31 Mar 2007 11:06:17 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Olaf Hering" <olaf@aepfle.de>
Subject: Re: [PATCH] autodetect serial console on efika
In-Reply-To: <20070331150823.GA25421@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <20070331150823.GA25421@aepfle.de>
Cc: linuxppc-dev@ozlabs.org, Paul Mackeras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 3/31/07, Olaf Hering <olaf@aepfle.de> wrote:
> Efika boards have to be booted with console=ttyPSC0 unless there is a
> graphics card plugged in. Detect if the firmware stdout is the serial
> connector.
>
> Signed-off-by: Olaf Hering <olaf@aepfle.de>
Acked-by: Grant Likely <grant.likely@secretlab.ca>

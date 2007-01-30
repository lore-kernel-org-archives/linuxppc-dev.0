Return-Path: <vbordug@ru.mvista.com>
Received: from localhost.localdomain (unknown [85.94.3.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C0EA7DE196
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Jan 2007 10:21:02 +1100 (EST)
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 0/3] 8560 && 8272 fixes resubmit
Date: Wed, 31 Jan 2007 02:08:35 +0300
Message-ID: <20070130230711.21111.52924.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul,

Here is next iteration with Kumar's feedback addressed. Other than I don't want to tackle 
with moving cpm2_cascade() for now as these are more fixes than rework (but that belongs 
to the list of things to happen next, I agree). 

-- 
Sincerely, Vitaly

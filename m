Return-Path: <arrigo@vision.caltech.edu>
Received: from kla-tencor.com (smtp.kla-tencor.com [192.146.1.134])
	by ozlabs.org (Postfix) with ESMTP id 075352BE83
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Nov 2004 05:29:07 +1100 (EST)
Received: from [10.35.5.214] ([10.35.5.214])
	by kla-tencor.com (8.11.6+Sun/KLAC-1.0i) with ESMTP id iA2ISuj03737
	for <linuxppc-dev@ozlabs.org>; Tue, 2 Nov 2004 10:28:56 -0800 (PST)
Message-ID: <4187D1DE.90203@vision.caltech.edu>
Date: Tue, 02 Nov 2004 10:28:46 -0800
From: Arrigo Benedetti <arrigo@vision.caltech.edu>
MIME-Version: 1.0
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: G5 clock frequency scaling
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Does anyone know if the current IBM 970 chips in dual G5 Powermacs and 
Xserves is under any clock frequency
scaling control? In other words, is the clock freuquency always 
guardanteed to be the nominal, or it may change
based on temperature? If this is the case, does the linux kernel have 
any control on it?

Thanks
-Arrigo

Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2B33767A30
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Feb 2005 10:08:03 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "William A.(Andy) Adamson" <andros@citi.umich.edu>
In-Reply-To: <20050203203804.CEF201BAA9@citi.umich.edu>
References: <20050203203804.CEF201BAA9@citi.umich.edu>
Content-Type: text/plain
Date: Fri, 04 Feb 2005 10:07:14 +1100
Message-Id: <1107472035.2363.59.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: 2.6.11-rc2 on powerbook g4 - lost interrupt
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2005-02-03 at 15:38 -0500, William A.(Andy) Adamson wrote:
> hello
> 
> i'm trying to get 2.6.11-rc2 to run on my powerbook g4, cpuinfo below. i found 
> the discussion and patch for the adb-probe hang which i experienced. now i'm 
> finding the ide subsystem is loosing interrupt's talking to the harddisk, hda. 
> i attached my kernel config. i looked in the email archive and didn't find 
> anything relevant. any suggestions would be appreciated. i delevelop NFSv4 on 
> linux, and need the latest kernels....

Can you try disabling cpufreq support and let me know if that helps ?

Ben.

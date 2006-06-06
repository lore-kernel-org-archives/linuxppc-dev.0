Return-Path: <thiagogalesi@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.172])
	by ozlabs.org (Postfix) with ESMTP id 16CB067B1E
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jun 2006 03:09:57 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id j3so1714288ugf
	for <linuxppc-dev@ozlabs.org>; Tue, 06 Jun 2006 10:09:55 -0700 (PDT)
Message-ID: <82ecf08e0606061009u7fb89cd9k42757d4d8c1cbf54@mail.gmail.com>
Date: Tue, 6 Jun 2006 14:09:55 -0300
From: "Thiago Galesi" <thiagogalesi@gmail.com>
To: "Kallol Biswas" <Kallol_Biswas@pmc-sierra.com>
Subject: Re: process starvation with 2.6 scheduler
In-Reply-To: <478F19F21671F04298A2116393EEC3D527421D@sjc1exm08.pmc_nt.nt.pmc-sierra.bc.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <478F19F21671F04298A2116393EEC3D527421D@sjc1exm08.pmc_nt.nt.pmc-sierra.bc.ca>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Did you try it with a _real_ CPU? My bet is that the timer interrupt
is overwhelming the CPU (even at 100Hz, 400kHz is too slow).

-- 
-
Thiago Galesi

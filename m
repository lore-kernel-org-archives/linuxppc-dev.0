Return-Path: <vneethv@gmail.com>
Received: from sam.nabble.com (sam.nabble.com [216.139.236.26])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 08C992C0382
 for <linuxppc-dev@ozlabs.org>; Fri,  8 Mar 2013 18:05:32 +1100 (EST)
Received: from tom.nabble.com ([192.168.236.105])
 by sam.nabble.com with esmtp (Exim 4.72)
 (envelope-from <vneethv@gmail.com>) id 1UDr6B-0004Ta-Fp
 for linuxppc-dev@ozlabs.org; Thu, 07 Mar 2013 22:48:11 -0800
Date: Thu, 7 Mar 2013 22:48:11 -0800 (PST)
From: vneethv <vneethv@gmail.com>
To: linuxppc-dev@ozlabs.org
Message-ID: <1362725291483-69101.post@n7.nabble.com>
In-Reply-To: <CAFbQSaB=gw3+P0-yDhjOFnP2z_sYzUHbw+MuFp8QLdF7xyuGUA@mail.gmail.com>
References: <CAFbQSaCxSVDRW=kcjkrbrm=8Sy4N0q29ALfqb4o3UdB3crY64g@mail.gmail.com>
 <CAFbQSaB=gw3+P0-yDhjOFnP2z_sYzUHbw+MuFp8QLdF7xyuGUA@mail.gmail.com>
Subject: Re: PREMPT_RT
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

huh..My VDSO patch was not the culprit..! the issue was with
spin_lock_irqsave calls...! modify the same to
raw_spin_lock_irqsave..problem solved..! 
the rtpatch was not applied properly.




--
View this message in context: http://linuxppc.10917.n7.nabble.com/PREMPT-RT-tp68107p69101.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.

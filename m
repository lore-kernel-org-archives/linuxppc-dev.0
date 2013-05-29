Return-Path: <knight@princeton.edu>
Received: from skuld.princeton.edu (skuld.Princeton.EDU [128.112.173.239])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 417DC2C0325
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 May 2013 01:57:24 +1000 (EST)
Received: from odin.Princeton.EDU (odin.Princeton.EDU [128.112.172.115])
 (authenticated bits=0)
 by skuld.princeton.edu (8.14.5/8.14.5) with ESMTP id r4TFFEpI013760
 (version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 May 2013 11:15:14 -0400
Message-ID: <51A61B82.5050508@princeton.edu>
Date: Wed, 29 May 2013 11:15:14 -0400
From: Robert Knight <knight@princeton.edu>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: IBM OpenPower 720 ipr driver woes
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Sometime after kernel 3.3.4, Fedora 17 running on an IBM OpenPower 720 
stopped being able to read the SCSI disks with an error concerning a 
return code -1.  In the updates since, it has not resumed working.

Does the ipr driver no longer support this (admittedly ancient) hardware?

Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 400bJD3MTgzF09P
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Mar 2018 11:26:36 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2D0QEqk082154
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Mar 2018 20:26:34 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gp1b24xbj-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Mar 2018 20:26:33 -0400
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Tue, 13 Mar 2018 00:26:31 -0000
Subject: Re: [PATCH 2/2] misc: ocxl: use put_device() instead of
 device_unregister()
To: Arvind Yadav <arvind.yadav.cs@gmail.com>, sudeep.dutt@intel.com,
 ashutosh.dixit@intel.com, arnd@arndb.de, gregkh@linuxfoundation.org,
 fbarrat@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1520849284.git.arvind.yadav.cs@gmail.com>
 <8c4d28703e408b71284af68d07c117e7b8c8a75a.1520849284.git.arvind.yadav.cs@gmail.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Tue, 13 Mar 2018 11:26:25 +1100
MIME-Version: 1.0
In-Reply-To: <8c4d28703e408b71284af68d07c117e7b8c8a75a.1520849284.git.arvind.yadav.cs@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <c4f9c9c3-465a-8f95-ff62-4984d556cf20@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/03/18 22:36, Arvind Yadav wrote:
> if device_register() returned an error! Always use put_device()
> to give up the reference initialized.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

This looks right, thanks for picking it up.

Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited

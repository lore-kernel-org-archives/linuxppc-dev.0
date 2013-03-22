Return-Path: <gang.chen@asianux.com>
Received: from intranet.asianux.com (intranet.asianux.com [58.214.24.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id D9B3C2C00C3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Mar 2013 17:46:59 +1100 (EST)
Message-ID: <514BFE3E.5000906@asianux.com>
Date: Fri, 22 Mar 2013 14:46:22 +0800
From: Chen Gang <gang.chen@asianux.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [Suggestion] PowerPC: kernel: cross compiling issue with
 allmodconfig
References: <51428C81.6000204@asianux.com>
 <25841.1363323174@ale.ozlabs.ibm.com> <5142AE27.7060003@asianux.com>
 <514AA0D9.1090509@asianux.com> <514AC418.1070806@gmail.com>
 <1363869499.17680.25.camel@pasglop>
In-Reply-To: <1363869499.17680.25.camel@pasglop>
Content-Type: text/plain; charset=UTF-8
Cc: sfr@canb.auug.org.au, Michael Neuling <mikey@neuling.org>, matt@ozlabs.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "paulus@samba.org" <paulus@samba.org>, imunsie@au1.ibm.com,
 Chen Gang F T <chen.gang.flying.transformer@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2013年03月21日 20:38, Benjamin Herrenschmidt wrote:
> On Thu, 2013-03-21 at 16:26 +0800, Chen Gang F T wrote:
>> >   it seems:
>> >     only move slb_miss_realmode to the end, can fix this issue without negative effect.
> Thanks. I'm currently on vacation, I'll have a closer look when I'm back
> unless Stephen or Paulus wants to shoot that to Linus while I'm
> away.
> 

  ok, I prefer to wait you back to have a closer look.

  thanks.

  :-)


> Cheers,
> Ben.
> 


-- 
Chen Gang

Asianux Corporation

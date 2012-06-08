Return-Path: <michael@ellerman.id.au>
References: <20120604154213.173feecb@kryten> <20120604154519.48ea1aa9@kryten>
 <1339123423.3330.5.camel@concordia> <20120608140204.49f475e8@kryten>
In-Reply-To: <20120608140204.49f475e8@kryten>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH 5/5] powerpc: iommu: Implement IOMMU pools to improve
 multiqueue adapter performance
From: Michael Ellerman <michael@ellerman.id.au>
Date: Fri, 08 Jun 2012 14:03:30 +1000
To: Anton Blanchard <anton@samba.org>
Message-ID: <8b2f8117-9228-4d53-8bf5-9a742d27f01e@email.android.com>
Cc: olof@lixom.net, paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anton Blanchard <anton@samba.org> wrote:

>
>Hi,
>
>> Breaks the cell code with:
>> 
>> arch/powerpc/platforms/cell/iommu.c:521:15: error: 'struct
>> iommu_table' has no member named 'it_hint'
>
>Yuck, I'll spin a fix. There's no need for the code to bump the hint.

OK, I can fix it up. 

Cheers


-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.

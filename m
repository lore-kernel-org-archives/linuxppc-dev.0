Return-Path: <qiudayu@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp03.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9D6DD2C007C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 May 2013 15:57:43 +1000 (EST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <qiudayu@linux.vnet.ibm.com>;
 Wed, 22 May 2013 11:22:36 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 2D48AE0054
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 May 2013 11:30:10 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r4M5vVhJ58392732
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 May 2013 11:27:31 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r4M5vZ1i004276
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 May 2013 05:57:36 GMT
Received: from [9.111.29.142] (win-q68h7f9m03i.cn.ibm.com [9.111.29.142])
 by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
 r4M5vWt0004127
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 May 2013 05:57:33 GMT
Message-ID: <519C5E48.8040401@linux.vnet.ibm.com>
Date: Wed, 22 May 2013 13:57:28 +0800
From: Mike Qiu <qiudayu@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 0/3] Enable multiple MSI feature in pSeries
References: <1358235536-32741-1-git-send-email-qiudayu@linux.vnet.ibm.com>
 <20130521144548.GB21632@dhcp-26-207.brq.redhat.com>
In-Reply-To: <20130521144548.GB21632@dhcp-26-207.brq.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

于 2013/5/21 22:45, Alexander Gordeev 写道:
> On Tue, Jan 15, 2013 at 03:38:53PM +0800, Mike Qiu wrote:
>> The test results is shown by 'cat /proc/interrups':
>>            CPU0       CPU1       CPU2       CPU3
>> 16:     240458     261601     226310     200425      XICS Level     IPI
>> 17:          0          0          0          0      XICS Level     RAS_EPOW
>> 18:         10          0          3          2      XICS Level     hvc_console
>> 19:     122182      28481      28527      28864      XICS Level     ibmvscsi
>> 20:        506    7388226        108        118      XICS Level     eth0
>> 21:          6          5          5          5      XICS Level     host1-0
>> 22:        817        814        816        813      XICS Level     host1-1
> Hi Mike,
>
> I am curious if pSeries firmware allows changing affinity masks independently
> for multiple MSIs? I.e. in your example, would it be possible to assign IRQ21
> and IRQ22 to different CPUs?
Yes, as Ben says, this is very different from other firmware :)

Thanks
Mike
>
> Thanks!
>
>> LOC:     398077     316725     231882     203049   Local timer interrupts
>> SPU:       1659        919        961        903   Spurious interrupts
>> CNT:          0          0          0          0   Performance
>> monitoring interrupts
>> MCE:          0          0          0          0   Machine check exceptions

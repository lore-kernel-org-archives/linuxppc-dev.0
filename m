Return-Path: <knight@princeton.edu>
Received: from skuld.princeton.edu (skuld.Princeton.EDU [128.112.173.239])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B7FB62C00C3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Oct 2013 02:41:34 +1100 (EST)
Message-ID: <525FFACB.8010303@princeton.edu>
Date: Thu, 17 Oct 2013 10:57:15 -0400
From: Robert Knight <knight@princeton.edu>
MIME-Version: 1.0
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Subject: Re: IBM OpenPower 720 ipr driver woes
References: <51A61B82.5050508@princeton.edu>
 <51A644C2.5090300@linux.vnet.ibm.com> <51AD088C.8040803@princeton.edu>
 <20130604000130.GA25055@thor.bakeyournoodle.com>
 <51AD45A4.9080702@princeton.edu>
 <20130604031651.GA3373@thor.bakeyournoodle.com>
 <20130604035223.GA27964@shangw.(null)> <51AFAA2C.5060304@princeton.edu>
 <51B07336.7040609@linux.vnet.ibm.com> <51B08311.3080406@princeton.edu>
 <20130607002459.GA5512@shangw.(null)>
In-Reply-To: <20130607002459.GA5512@shangw.(null)>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Brian King <brking@linux.vnet.ibm.com>,
 Wendy Xiong <wenxiong@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/06/2013 08:24 PM, Gavin Shan wrote:
> On Thu, Jun 06, 2013 at 08:39:45AM -0400, Robert Knight wrote:
>> On 06/06/2013 07:32 AM, Brian King wrote:
>>> On 06/05/2013 04:14 PM, Robert Knight wrote:
>>>> On 6/3/2013 11:52 PM, Gavin Shan wrote:
>>>>> On Tue, Jun 04, 2013 at 01:16:52PM +1000, Tony Breeds wrote:
>>>>>> On Mon, Jun 03, 2013 at 09:40:52PM -0400, Robert Knight wrote:
>>>>>>> On 6/3/2013 8:01 PM, Tony Breeds wrote:
>>>>>>>> On Mon, Jun 03, 2013 at 05:20:12PM -0400, Robert Knight wrote:
> .../...
>
>> Yes.  I've started rebuilding the kernel and I'm up to the module
>> building part, so I'd say it is solid.  Will this patch make it into
>> some version of the kernel?
>>
> The patch is being pushed to mainline or linux-next, and backported
> to stable-kernel (v3.4+)
>
>
>> What was killing me was that it would not complete boot.  It now
>> does.  I see:
>>
>> [   11.934481] scsi 0:0:15:0: Resetting device
>> [   11.934813] ipr 0001:d0:01.0: Adapter being reset as a result of
>> error recovery.
>>
>> on each boot.  It does not appear to affect operation.
>>
>> Thank you and the rest of the team for your rapid and helpful responses.
>>
> Thanks,
> Gavin
>
Well, it's four months later and I'm trying to get Fedora 20 Alpha to 
install on that same machine.  It appears to still have the same 
problem.  Did that patch ever make it into the mainline?

Strangely, the kernel from the installer (using DVD image) does NOT have 
the problem, only the installed system.

Regards,
Robert

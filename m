Return-Path: <jschopp@austin.ibm.com>
Message-ID: <443F6A10.3000405@austin.ibm.com>
Date: Fri, 14 Apr 2006 11:23:28 +0200
From: Joel Schopp <jschopp@austin.ibm.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Subject: Re: [Cbe-oss-dev] [patch] cell: correctly detect systemsim host
References: <443E38FE.2050304@de.ibm.com>
	<200604131344.26392.arnd.bergmann@de.ibm.com>
In-Reply-To: <200604131344.26392.arnd.bergmann@de.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Christian Krafft <krafft@de.ibm.com>, cbe-oss-dev@ozlabs.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Systemsim uses a different compatible property in the device tree.
>>
>> Signed-off-by: Christian Krafft <krafft@de.ibm.com>
> 
> Thanks.
> 
> I'm wondering if we should have that upstream, since some
> more patches are currently required to run on systemsim
> anyway. For now, I'll keep it in my tree.

It is clean enough to go upstream and doesn't depend on anything else, 
so I say put it upstream.  That's just one less patch to carry outside 
of mainline.  No reason to punish perfectly good patches just because 
the rest of the systemsim stuff isn't ready yet.

-Joel

Acked-by: Joel Schopp <jschopp@austin.ibm.com>

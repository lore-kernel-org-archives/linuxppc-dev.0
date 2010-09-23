Return-Path: <tmarri@apm.com>
Received: from exprod5og105.obsmtp.com (exprod5og105.obsmtp.com [64.18.0.180])
	by ozlabs.org (Postfix) with SMTP id C6146B7100
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 24 Sep 2010 08:44:44 +1000 (EST)
Received: by qyk7 with SMTP id 7so426034qyk.14
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 23 Sep 2010 15:44:42 -0700 (PDT)
From: Tirumala Marri <tmarri@apm.com>
References: <1285279839-16588-1-git-send-email-tmarri@apm.com>
	<4C9BD6DC.3070707@intel.com>
In-Reply-To: <4C9BD6DC.3070707@intel.com>
MIME-Version: 1.0
Date: Thu, 23 Sep 2010 15:44:41 -0700
Message-ID: <fe45b421a909d749a6cf583426a1ce6d@mail.gmail.com>
Subject: RE: [PATCH v1 1/4] PPC4xx: Generalizing ADMA driver modifications
To: Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-raid@vger.kernel.org, herbert@gondor.hengli.com.au,
	linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org,
	yur@emcraft.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>
> Did you look at this changelog before sending?  It just deletes 4000
> lines of code??
[Marri] The reason I have to send it in different file is the size of the
patch.
There seem to be issue with patch sizes 200k or more.

Return-Path: <krafft@de.ibm.com>
Date: Tue, 13 Feb 2007 20:20:15 +0100
From: Christian Krafft <krafft@de.ibm.com>
To: Christian Krafft <krafft@de.ibm.com>
Subject: Re: [Cbe-oss-dev] [patch v3] powerpc: add PMI driver for cell blade
Message-ID: <20070213202015.3b79c2f8@localhost>
In-Reply-To: <20070213194806.3c266282@localhost>
References: <20070209183529.67d542d5@localhost>
	<20070209184530.4c8bc2be@localhost>
	<20070209222956.GH1827@localdomain>
	<20070212101222.24abe14c@localhost>
	<20070213143418.06fa01b5@localhost>
	<20070213194436.0306d18a@localhost>
	<20070213194806.3c266282@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Nathan Lynch <ntl@pobox.com>,
	cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 13 Feb 2007 19:48:06 +0100
Christian Krafft <krafft@de.ibm.com> wrote:

> +
> +	data->work_queue =3D create_workqueue("pmi");
> +	INIT_WORK(&data->work, pmi_notify_handlers);
> +

That's not what I wanted!
Will send an update.


--=20
Mit freundlichen Gr=FCssen,
kind regards,

Christian Krafft
IBM Systems & Technology Group,=20
Linux Kernel Development
IT Specialist

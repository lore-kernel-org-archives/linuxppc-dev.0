Return-Path: <jonsmirl@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.239])
	by ozlabs.org (Postfix) with ESMTP id 61832DE61D
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jan 2009 03:29:42 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so8203462rvb.9
	for <linuxppc-dev@ozlabs.org>; Tue, 06 Jan 2009 08:29:41 -0800 (PST)
Message-ID: <9e4733910901060829y6e8fcc7pb2de65ce807930c3@mail.gmail.com>
Date: Tue, 6 Jan 2009 11:29:40 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] Add the of_find_i2c_device_by_node function.
In-Reply-To: <20081230201107.26810.71390.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20081230201107.26810.71390.stgit@localhost>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Dec 30, 2008 at 3:11 PM, Jon Smirl <jonsmirl@gmail.com> wrote:
> Add the of_find_i2c_device_by_node function. This allows you to follow
> a reference in the device tree to an i2c device node and then locate
> the linux device instantiated by the device tree. Example use, an i2s
> codec controlled by i2c.

Did anyone pick this patch up? You need it to write ALSA ASOC drivers.

-- 
Jon Smirl
jonsmirl@gmail.com
